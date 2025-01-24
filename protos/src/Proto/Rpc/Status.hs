{- This file was auto-generated from rpc/status.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Rpc.Status (
        Status()
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
import qualified Proto.Google.Protobuf.Any
{- | Fields :
     
         * 'Proto.Rpc.Status_Fields.code' @:: Lens' Status Data.Int.Int32@
         * 'Proto.Rpc.Status_Fields.message' @:: Lens' Status Data.Text.Text@
         * 'Proto.Rpc.Status_Fields.details' @:: Lens' Status [Proto.Google.Protobuf.Any.Any]@
         * 'Proto.Rpc.Status_Fields.vec'details' @:: Lens' Status (Data.Vector.Vector Proto.Google.Protobuf.Any.Any)@ -}
data Status
  = Status'_constructor {_Status'code :: !Data.Int.Int32,
                         _Status'message :: !Data.Text.Text,
                         _Status'details :: !(Data.Vector.Vector Proto.Google.Protobuf.Any.Any),
                         _Status'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Status where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Status "code" Data.Int.Int32 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Status'code (\ x__ y__ -> x__ {_Status'code = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Status "message" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Status'message (\ x__ y__ -> x__ {_Status'message = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Status "details" [Proto.Google.Protobuf.Any.Any] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Status'details (\ x__ y__ -> x__ {_Status'details = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Status "vec'details" (Data.Vector.Vector Proto.Google.Protobuf.Any.Any) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Status'details (\ x__ y__ -> x__ {_Status'details = y__}))
        Prelude.id
instance Data.ProtoLens.Message Status where
  messageName _ = Data.Text.pack "google.rpc.Status"
  packedMessageDescriptor _
    = "\n\
      \\ACKStatus\DC2\DC2\n\
      \\EOTcode\CAN\SOH \SOH(\ENQR\EOTcode\DC2\CAN\n\
      \\amessage\CAN\STX \SOH(\tR\amessage\DC2.\n\
      \\adetails\CAN\ETX \ETX(\v2\DC4.google.protobuf.AnyR\adetails"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        code__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "code"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int32Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int32)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"code")) ::
              Data.ProtoLens.FieldDescriptor Status
        message__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "message"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"message")) ::
              Data.ProtoLens.FieldDescriptor Status
        details__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "details"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Any.Any)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"details")) ::
              Data.ProtoLens.FieldDescriptor Status
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, code__field_descriptor),
           (Data.ProtoLens.Tag 2, message__field_descriptor),
           (Data.ProtoLens.Tag 3, details__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Status'_unknownFields
        (\ x__ y__ -> x__ {_Status'_unknownFields = y__})
  defMessage
    = Status'_constructor
        {_Status'code = Data.ProtoLens.fieldDefault,
         _Status'message = Data.ProtoLens.fieldDefault,
         _Status'details = Data.Vector.Generic.empty,
         _Status'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Status
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Proto.Google.Protobuf.Any.Any
             -> Data.ProtoLens.Encoding.Bytes.Parser Status
        loop x mutable'details
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'details <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                          (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                             mutable'details)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'details") frozen'details x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "code"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"code") y x)
                                  mutable'details
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.getText
                                             (Prelude.fromIntegral len))
                                       "message"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"message") y x)
                                  mutable'details
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "details"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'details y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'details
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'details <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                   Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'details)
          "Status"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"code") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"message") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'details") _x))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData Status where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Status'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Status'code x__)
                (Control.DeepSeq.deepseq
                   (_Status'message x__)
                   (Control.DeepSeq.deepseq (_Status'details x__) ())))
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \\DLErpc/status.proto\DC2\n\
    \google.rpc\SUB\EMgoogle/protobuf/any.proto\"f\n\
    \\ACKStatus\DC2\DC2\n\
    \\EOTcode\CAN\SOH \SOH(\ENQR\EOTcode\DC2\CAN\n\
    \\amessage\CAN\STX \SOH(\tR\amessage\DC2.\n\
    \\adetails\CAN\ETX \ETX(\v2\DC4.google.protobuf.AnyR\adetailsBa\n\
    \\SOcom.google.rpcB\vStatusProtoP\SOHZ7google.golang.org/genproto/googleapis/rpc/status;status\248\SOH\SOH\162\STX\ETXRPCJ\138\SI\n\
    \\ACK\DC2\EOT\DC1\NUL3\SOH\n\
    \\194\ENQ\n\
    \\SOH\f\DC2\ETX\DC1\NUL\DC22\177\EOT Copyright 2022 Google LLC\n\
    \\n\
    \ Licensed under the Apache License, Version 2.0 (the \"License\");\n\
    \ you may not use this file except in compliance with the License.\n\
    \ You may obtain a copy of the License at\n\
    \\n\
    \     http://www.apache.org/licenses/LICENSE-2.0\n\
    \\n\
    \ Unless required by applicable law or agreed to in writing, software\n\
    \ distributed under the License is distributed on an \"AS IS\" BASIS,\n\
    \ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\n\
    \ See the License for the specific language governing permissions and\n\
    \ limitations under the License.\n\
    \2\131\SOH The canonical version of this proto can be found at\n\
    \ https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto\n\
    \\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\DC3\NUL\DC3\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\NAK\NUL#\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ETB\NUL\US\n\
    \\t\n\
    \\STX\b\US\DC2\ETX\ETB\NUL\US\n\
    \\b\n\
    \\SOH\b\DC2\ETX\CAN\NULN\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\CAN\NULN\n\
    \\b\n\
    \\SOH\b\DC2\ETX\EM\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\EM\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\SUB\NUL,\n\
    \\t\n\
    \\STX\b\b\DC2\ETX\SUB\NUL,\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ESC\NUL'\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\ESC\NUL'\n\
    \\b\n\
    \\SOH\b\DC2\ETX\FS\NUL!\n\
    \\t\n\
    \\STX\b$\DC2\ETX\FS\NUL!\n\
    \\190\ETX\n\
    \\STX\EOT\NUL\DC2\EOT%\NUL3\SOH\SUB\177\ETX The `Status` type defines a logical error model that is suitable for\n\
    \ different programming environments, including REST APIs and RPC APIs. It is\n\
    \ used by [gRPC](https://github.com/grpc). Each `Status` message contains\n\
    \ three pieces of data: error code, error message, and error details.\n\
    \\n\
    \ You can find out more about this error model and how to work with it in the\n\
    \ [API Design Guide](https://cloud.google.com/apis/design/errors).\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX%\b\SO\n\
    \e\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX(\STX\DC1\SUBX The status code, which should be an enum value of\n\
    \ [google.rpc.Code][google.rpc.Code].\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX(\STX\a\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX(\b\f\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX(\SI\DLE\n\
    \\236\SOH\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX.\STX\NAK\SUB\222\SOH A developer-facing error message, which should be in English. Any\n\
    \ user-facing error message should be localized and sent in the\n\
    \ [google.rpc.Status.details][google.rpc.Status.details] field, or localized\n\
    \ by the client.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX.\STX\b\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX.\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX.\DC3\DC4\n\
    \y\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX2\STX+\SUBl A list of messages that carry the error details.  There is a common set of\n\
    \ message types for APIs to use.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\EOT\DC2\ETX2\STX\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX2\v\RS\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX2\US&\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX2)*b\ACKproto3"