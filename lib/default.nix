{ lib, ... }:
let
  inherit (lib) mkOption types;
in
rec {
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  mkOpt' = type: default: mkOpt type default null;

  mkBoolOpt = mkOpt types.bool;

  mkBoolOpt' = mkOpt' types.bool;

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };
}
