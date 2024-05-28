{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module Main where

import Control.Monad (when)
import Data.ByteArray (convert)
import Data.ByteString (ByteString)
import Data.Either (isLeft)
import Data.Map (Map)
import Data.Text (Text)
import qualified Data.Text as T
import Hedgehog
import qualified Hedgehog.Gen as Gen
import Hedgehog.Main
import qualified Hedgehog.Range as Range
import Temporal.Codec.Encryption
import Temporal.Payload


genByteString :: MonadGen m => m ByteString
genByteString = Gen.bytes (Range.linear 0 1024)


genText :: MonadGen m => m Text
genText = T.pack <$> Gen.string (Range.linear 0 100) Gen.alphaNum


genMapTextByteString :: MonadGen m => m (Map Text ByteString)
genMapTextByteString =
  Gen.map (Range.linear 0 10) $
    (,) <$> genText <*> genByteString


genPayload :: MonadGen m => m Payload
genPayload = Payload <$> genByteString <*> genMapTextByteString


genKey :: MonadGen m => m Key
genKey = keyFromBytes . convert <$> Gen.bytes (Range.singleton 32)


genKeyName :: MonadGen m => m Text
genKeyName = T.pack <$> Gen.string (Range.linear 1 100) Gen.alphaNum


prop_roundtripEncryption :: Property
prop_roundtripEncryption = property $ do
  k <- forAll genKey
  -- Initialize cipher and encrypt the plaintext
  let Right cipher = initCipher k
  somePayload <- forAll genPayload
  codec <- evalEitherM $ mkEncryptionCodec ("test", cipher) mempty
  encoded <- evalIO $ encode codec somePayload

  -- Ensure the encrypted payload is not the plaintext
  when (somePayload.payloadData /= "") $ do
    encoded /== somePayload

  -- Attempt to decrypt the encrypted payload
  (Right decoded) <- evalIO $ decode codec encoded

  -- Verify the decrypted payload matches the original plaintext
  (decoded :: Payload) === somePayload


prop_failedDecryptionWithTamperedCiphertext :: Property
prop_failedDecryptionWithTamperedCiphertext = property $ do
  k <- forAll genKey
  cipher <- evalEither $ initCipher k
  somePayload <- forAll $ Gen.filter (\p -> p.payloadData /= "") genPayload
  codec <- evalEitherM $ mkEncryptionCodec ("test", cipher) mempty
  encoded <- evalIO $ encode codec somePayload

  let tamperedEncoded = encoded {payloadData = "tampered" <> payloadData encoded}

  -- Attempt to decrypt the encrypted payload
  decoded <- evalIO $ decode codec tamperedEncoded
  assert $ isLeft (decoded :: Either String Payload)


main :: IO ()
main =
  defaultMain
    [ checkParallel $$(discover)
    ]
