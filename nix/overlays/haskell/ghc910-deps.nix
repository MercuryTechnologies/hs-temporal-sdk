{ haskell, ... }:
_hfinal: hprev:
let
  inherit (haskell.lib.compose) doJailbreak;
in
{
  uuid = doJailbreak hprev.uuid;
}
