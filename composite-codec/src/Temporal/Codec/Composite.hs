{-# OPTIONS_GHC -fplugin=IfSat.Plugin #-}
module Temporal.Codec.Composite 
  ( defaultCodec
  , Composite(..)
  , module Data.Constraint.If
  ) where

import Data.Constraint.If
import Data.Kind
import qualified Data.Map.Strict as Map
import Data.Proxy
import Temporal.Payload
import GHC.TypeLits

-- | The 'Composite' codec allows you to combine multiple codecs into one.
--
-- The codecs are tried in order, and the first one that succeeds is used.
-- If none of the codecs succeed, the compile-time error message will indicate
-- the type that didn't satisfy any of the specified codecs.
--
-- This Codec is useful when you want to support multiple serialization formats
-- and choose the best / most performant one for each type.
--
-- Note that this Codec relies upon the 'if-instance' package, which supplies
-- a compiler plugin that allows us to use this. You must add the following
-- pragma to the module that registers your workflow code:
--
-- > {-# OPTIONS_GHC -fplugin=IfSat.Plugin #-}
-- > -- ^ Put this at the top of the module that registers your workflow code.
-- >
-- > let testFn :: Int -> Text -> Bool -> W.Workflow () () (Int, Text, Bool)
-- >     testFn a b c = pure (a, b, c)
-- >     wf = W.provideWorkflow defaultCodec "test" () testFn
-- >     conf = configure () () $ do
-- >       addWorkflow wf
--
-- If you forget to add this pragma, your code will fail to compile with
-- a message like:
--
-- > hs-temporal/test/IntegrationSpec.hs:66:16: error:
-- >    • No instance for (Codec Null ()
-- >                       Data.Constraint.If.|| Codec
-- >                                               (Temporal.Payload.Composite
-- >                                                  '[Binary, Protobuf, JSON])
-- >                                               ())
-- >        arising from a use of ‘W.provideWorkflow’
-- >    • In the expression:
-- >        W.provideWorkflow defaultCodec "test" () testFn
-- >      In an equation for ‘wf’:
-- >          wf = W.provideWorkflow defaultCodec "test" () testFn
-- >      In the expression:
-- >        do taskQueue <- W.TaskQueue <$> uuidText
-- >           let testFn :: W.Workflow () () ()
-- >               testFn = pure ()
-- >               ....
-- >           withWorker conf
-- >             $ do wfId <- uuidText
-- >                  let ...
-- >                  ....
-- >   |
-- >66 |           wf = W.provideWorkflow defaultCodec "test" () testFn
-- >   |                ^^^^^^^^^^^^^^^^^

data Composite (codecs :: [Type]) where
  CompositeNil :: Composite '[]
  CompositeCons :: codec -> Composite codecs -> Composite (codec ': codecs)

instance TypeError (('ShowType a) ':<>: 'Text " is not supported by any of the provided codecs") => Codec (Composite '[]) a where
  messageType = error "unreachable"
  encodingType = error "unreachable"
  encodePayload = error "unreachable"
  decode _ _ = Left "No recognized codec for this type"

instance (Codec fmt a || Codec (Composite codecs) a) => Codec (Composite (fmt ': codecs)) a where
  messageType fmt = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of CompositeCons codec _ -> messageType codec) 
    (case fmt of CompositeCons _ codecs -> messageType codecs)
  encodingType fmt = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of CompositeCons codec _ -> encodingType codec) 
    (case fmt of CompositeCons _ codecs -> encodingType codecs)
  encodePayload fmt = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of CompositeCons codec _ -> encodePayload codec)
    (case fmt of CompositeCons _ codecs -> encodePayload codecs)
  decode fmt payload = dispatch @(Codec fmt a) @(Codec (Composite codecs) a)
    (case fmt of 
      CompositeCons codec codecs -> if Just (encodingType codec (Proxy @a)) == payload.inputPayloadMetadata Map.!? "encoding"
        then decode codec payload
        else ifSat @(Codec (Composite codecs) a)
          (decode codecs payload)
          (Left "No codec for this type supports this payload")
    )
    (case fmt of CompositeCons _ codecs -> decode codecs payload)

defaultCodec :: Composite '[Null, Binary, Protobuf, JSON]
defaultCodec = CompositeCons Temporal.Payload.Null $ CompositeCons Binary $ CompositeCons Protobuf $ CompositeCons JSON CompositeNil
