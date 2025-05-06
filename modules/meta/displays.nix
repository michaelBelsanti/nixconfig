{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  unify.options = {
    primaryDisplay = mkOption {
      type = types.lazyAttrsOf types.raw;
      default = { };
    };
    displays = mkOption {
      type = types.lazyAttrsOf (
        types.submodule (
          { name, config, ... }:
          {
            options = {
              name = mkOption {
                default = name;
                readOnly = true;
              };
              primary = mkOption {
                type = types.bool;
                default = false;
              };
              refreshRate = mkOption {
                type = types.int;
                default = 60;
              };
              width = mkOption {
                type = types.int;
                default = 1920;
              };
              height = mkOption {
                type = types.int;
                default = 1080;
              };
              x = mkOption {
                type = types.int;
                default = 0;
              };
              y = mkOption {
                type = types.int;
                default = 0;
              };
              scaling = mkOption {
                type = types.float;
                default = 1.0;
              };
              roundScaling = mkOption {
                type = types.int;
                default = builtins.ceil config.scaling;
              };
            };
          }
        )
      );
    };
  };
}
