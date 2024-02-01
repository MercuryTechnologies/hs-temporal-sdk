{-# LANGUAGE CPP #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE RecordWildCards #-}
-- | 
-- Module: Temporal.Bundle.TH
-- Description: Reduce Temporal.Bundle boilerplate with Template Haskell.
--
-- This module provides Template Haskell functions for generating the
-- boilerplate required to use the Temporal.Bundle module.
--
-- This is generally the easiest way to define groups of related
-- activities and workflows with minimal boilerplate.
--
-- See 'Temporal.Bundle' for more example code.
module Temporal.Bundle.TH 
  ( temporalBundle
  , DeclareRecordConfig(..)
  ) where

import Data.EvalRecord.TH
import Language.Haskell.TH (DecsQ)

-- | Defines a synonym for the bare type with the same name.
-- The strippable definition is suffixed by B, and the covered type is suffixed by H.
temporalBundle :: DecsQ -> DecsQ
temporalBundle = mkEvalRecord
