{
  lib,
  hostname,
  config,
  mylib,
  ...
}:
{

  args.host.is = tag: lib.lists.elem tag config.host.${hostname}.tags;
  hostOptions = {
    displays = lib.mkOption {
      type = lib.types.attrsOf lib.types.submodule (
        { name, config, ... }:
        {
          options = {
            name = lib.mkOptions {
              value = name;
              readOnly = true;
            };
            primary = mylib.mkBool false;
            refreshRate = lib.mkOption {
              type = lib.types.int;
              default = 60;
            };
            width = lib.mkOption {
              type = lib.types.int;
              default = 60;
            };
            height = lib.mkOption {
              type = lib.types.int;
              default = 60;
            };
            x = lib.mkOption {
              type = lib.types.int;
              default = 60;
            };
            y = lib.mkOption {
              type = lib.types.int;
              default = 60;
            };
            scaling = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
            };
            roundScaling = lib.mkOption {
              type = lib.types.int;
              default = builtins.ceil config.scaling;
            };
          };
        }
      );
    };
  };
}
