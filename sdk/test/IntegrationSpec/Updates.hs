{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Unused LANGUAGE pragma" #-}

module IntegrationSpec.Updates where

import Temporal.Activity
import Temporal.Client
import Temporal.Duration
import Temporal.TH
import Temporal.Workflow


-- - Happy path update:
--   - Without validator
--   - With validator
-- - Update that causes a workflow to suspend
-- - Validator that rejects
-- - Validator that throws an exception
-- - Workflow that throws an exception
-- - Update that throws an exception
--   - Without validator
--   - With validator
-- - Malformed inputs/payloads
-- - Workflow canceled while running update (see ts-sdk's handling)
-- - Workflow exits while running update (see ts-sdk's handling)
-- - Interceptors
-- - Payload processors are being applied
--
-- - Client:
--   - Making sure we throw the right exceptions
--   - Interceptors are being run on the client
--
-- - Ideas:
--   - Start vs execute semantics for update
