{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.hostConfig = mkOption {
    default = { };
    type = types.attrsOf (
      types.submodule {
        options = {
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
                    refresh = mkOption {
                      type = types.float;
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
                    vrr = mkOption {
                      type = types.enum [
                        true
                        false
                        "on-demand"
                      ];
                      default = false;
                    };
                  };
                }
              )
            );
          };
        };
      }
    );
  };
}
