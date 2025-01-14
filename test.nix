let
  pkgs = import <unstable> {};
in
{
  temporal_bridge = pkgs.callPackage ./core/rust {};
}
