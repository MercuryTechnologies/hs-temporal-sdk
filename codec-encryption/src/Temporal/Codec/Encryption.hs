module Temporal.Codec.Encryption 
  ( Key
  , keyFromBytes
  , Cipher
  , keyToBase64
  , keyFromBase64
  , genSecretKey
  , initCipher
  , Encrypted
  , mkEncryptionCodec
  ) where

import Crypto.Cipher.AES (AES256)
import qualified Crypto.Cipher.AESGCMSIV as AESGCMSIV
import Crypto.Cipher.Types (AuthTag(..), KeySizeSpecifier(KeySizeFixed), cipherInit, cipherKeySize)
import Crypto.Error (CryptoFailable(..))
import Control.Error
import Control.Exception (displayException)
import Control.Monad.IO.Class
import qualified Crypto.Random.Types as CRT

import Data.ByteArray (ScrubbedBytes, convert)
import Data.ByteArray.Encoding
import Data.ByteString (ByteString)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.ProtoLens.Encoding (encodeMessage, decodeMessage)
import Temporal.Payload

-- An unencoded AES-256 encryption key
newtype Key where
  Key :: ScrubbedBytes -> Key
  deriving (Eq, Ord, Show)

newtype Cipher where
  Cipher :: AES256 -> Temporal.Codec.Encryption.Cipher

keyFromBytes :: ScrubbedBytes -> Key
keyFromBytes = Key

keyToBase64 :: Key -> ByteString
keyToBase64 (Key bytes) = convertToBase Base64 bytes

keyFromBase64 :: ByteString -> Either String Key
keyFromBase64 bs64 = case convertFromBase Base64 bs64 of
  Left e -> Left e
  Right bs -> Right $ Key (bs :: ScrubbedBytes)

-- | Generates a string of bytes (key) of a specific length for a given block cipher
genSecretKey :: forall m. (CRT.MonadRandom m) => m Key
genSecretKey = fmap Key $ CRT.getRandomBytes $ case cipherKeySize (undefined :: AES256) of
  KeySizeFixed n -> n
  _ -> error "AES256 key size should fixed"

-- | Initialize an AES256 cipher
initCipher :: Key -> Either String Cipher
initCipher (Key k) = case cipherInit k of
  CryptoFailed e -> Left $ show e
  CryptoPassed a -> Right $ Cipher a

data Encrypted = Encrypted
  { encryptionKeys :: Map ByteString Cipher
  , defaultKeyName :: ByteString
  , defaultKey :: Cipher
  -- TODO, fetchKey operation to support a KMS (key management system)
  }

mkEncryptionCodec :: MonadIO m => (ByteString, Cipher) -> Map ByteString Cipher -> m (Either String Encrypted)
mkEncryptionCodec (defaultKeyName, defaultKey) otherKeys = liftIO $ do
      pure $ Right $ Encrypted
        { encryptionKeys = Map.insert defaultKeyName defaultKey otherKeys
        , ..
        }

instance Codec Encrypted Payload where
  encoding _ _ = "binary/encrypted"
  encode Encrypted{..} x = do
    if x.payloadData == ""
    then pure x
    else do
      n <- AESGCMSIV.generateNonce
      let (Cipher k) = defaultKey
          (authTag, encrypted) = AESGCMSIV.encrypt k n (mempty :: ByteString) $ encodeMessage $ convertToProtoPayload x
      pure $ Payload encrypted
        (Map.fromList 
          [ ("encryption-key-id", defaultKeyName)
          , ("encoding", "binary/encrypted")
          , ("cipher", "AESGCMSIV")
          , ("nonce", convert n)
          , ("auth-tag", convert authTag)
          ])
  decode Encrypted{..} payload = case (,) <$> payload.payloadMetadata Map.!? "encoding" <*> payload.payloadMetadata Map.!? "cipher" of
    Just ("binary/encrypted", "AESGCMSIV") -> do
      if payload.payloadData == ""
      then pure $ Left "Payload data is missing"
      else runExceptT $ do
        keyName <- tryJust "Unable to decrypt Payload without encryption key id'" $ payload.payloadMetadata Map.!? "encryption-key-id"
        (Cipher k) <- tryJust ("Could not find encryption key: " <> show keyName) $ encryptionKeys Map.!? keyName
        rawNonce <- tryJust "Unable to decrypt Payload without nonce" $ payload.payloadMetadata Map.!? "nonce"
        n <- case AESGCMSIV.nonce rawNonce of
          CryptoPassed n -> pure n
          CryptoFailed e -> throwE $ displayException e
        authTag <- tryJust "Unable to decrypt Payload without auth tag" $ payload.payloadMetadata Map.!? "auth-tag"
        decrypted <- tryJust "Unable to decrypt Payload" $ AESGCMSIV.decrypt k n (mempty :: ByteString) payload.payloadData (AuthTag $ convert authTag)
        p <- tryRight $ decodeMessage decrypted
        pure $! convertFromProtoPayload p
    _ -> pure $ Right payload
