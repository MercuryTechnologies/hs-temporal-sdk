module Temporal.Codec.Encryption where

import Crypto.Cipher.AES (AES256)
import Crypto.Cipher.Types (BlockCipher(..), Cipher(..), IV, makeIV, ivAdd)
import Crypto.Error (CryptoFailable(..), CryptoError(..))
import Control.Monad.IO.Class
import qualified Crypto.Random.Types as CRT

import Data.ByteArray (ByteArray, ScrubbedBytes, convert)
import Data.ByteArray.Encoding
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import Data.IORef
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.ProtoLens.Encoding (encodeMessage, decodeMessage)
import Data.Proxy
import Temporal.Exception
import Temporal.Payload

data Key c where
  Key :: (BlockCipher c) => ScrubbedBytes -> Key c

keyToBase64 :: Key c -> ByteString
keyToBase64 (Key bytes) = convertToBase Base64 bytes

keyFromBase64 :: BlockCipher c => ByteString -> Either String (Key c)
keyFromBase64 bs64 = case convertFromBase Base64 bs64 of
  Left err -> Left err
  Right bs -> Right $ Key (bs :: ScrubbedBytes)

-- | Generates a string of bytes (key) of a specific length for a given block cipher
genSecretKey :: forall m c. (CRT.MonadRandom m, BlockCipher c) => Proxy c -> Int -> m (Key c)
genSecretKey _ = fmap Key . CRT.getRandomBytes

-- | Generate a random initialization vector for a given block cipher
genRandomIV :: forall m c. (CRT.MonadRandom m, BlockCipher c) => Proxy c -> m (Maybe (IV c))
genRandomIV _ = do
  bytes :: ByteString <- CRT.getRandomBytes $ blockSize (undefined :: c)
  return $ makeIV bytes

-- | Initialize a block cipher
initCipher :: (BlockCipher c) => Key c -> Either String c
initCipher (Key k) = case cipherInit k of
  CryptoFailed e -> Left $ show e
  CryptoPassed a -> Right a

encrypt :: (BlockCipher c) => c -> IV c -> ByteString -> ByteString
encrypt c initIV msg = convert initIV <> ctrCombine c initIV msg

decrypt :: (BlockCipher c) => c -> ByteString -> Either String ByteString
decrypt c msgWithIv = case makeIV ivBytes of
  Nothing -> Left "Invalid IV supplied for message"
  Just reconstructedIV -> Right $ encrypt c reconstructedIV encryptedMsg
  where 
    (ivBytes, encryptedMsg) = BS.splitAt aes256IVLength msgWithIv
    aes256IVLength = blockSize c

data Encrypted = Encrypted
  { encryptionKeys :: Map ByteString AES256
  , ivRef :: IORef (IV AES256)
  , defaultKeyName :: ByteString
  , defaultKey :: AES256
  -- TODO, fetchKey operation to support a KMS (key management system)
  }

mkEncryptionCodec :: MonadIO m => (ByteString, AES256) -> Map ByteString AES256 -> m (Either String Encrypted)
mkEncryptionCodec (defaultKeyName, defaultKey) otherKeys = liftIO $ do
  mRandomIV <- genRandomIV (Proxy @AES256)
  case mRandomIV of
    Nothing -> pure $ Left "Unable to generate IV for AES256 codec"
    Just randomIV -> do
      ivRef <- newIORef randomIV
      pure $ Right $ Encrypted
        { encryptionKeys = Map.insert defaultKeyName defaultKey otherKeys
        , ..
        }

instance Codec Encrypted RawPayload where
  encodingType _ _ = "binary/encrypted"
  encodePayload Encrypted{..} x = do
    iv <- atomicModifyIORef' ivRef (\iv -> let next = ivAdd iv 1 in (next, iv))
    pure $ encrypt defaultKey iv $ encodeMessage $ convertToProtoPayload x
  encodeExtraMetadata Encrypted{..} _ = Map.singleton "encryption-key-id" defaultKeyName
  decode Encrypted{..} payload = 
    if payload.inputPayloadMetadata Map.!? "encoding" /= (Just "binary/encrypted")
    then pure $ Right payload
    else 
      if payload.inputPayloadData == ""
      then pure $ Left "Payload data is missing"
      else
        case payload.inputPayloadMetadata Map.!? "encryption-key-id" of
          Nothing -> pure $ Left "Unable to decrypt Payload without encryption key id'"
          Just keyName -> case encryptionKeys Map.!? keyName of
            Nothing -> pure $ Left ("Could not find encryption key: " <> show keyName)
            Just k -> pure $ fmap convertFromProtoPayload (decrypt k payload.inputPayloadData >>= decodeMessage)
