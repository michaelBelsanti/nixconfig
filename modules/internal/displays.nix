{
  lib,
  mylib,
  ...
}:
{
  options = {
    displays = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule (
          { name, config, ... }:
          {
            options = {
              name = lib.mkOptions {
                value = name;
                readOnly = true;
              };
              primary = mylib.mkBool false;
              refreshRate = mylib.mkOption lib.types.int 60;
              width = mylib.mkOption lib.types.int 60;
              height = mylib.mkOption lib.types.int 60;
              x = mylib.mkOption lib.types.int 60;
              y = mylib.mkOption lib.types.int 60;
              scaling = mylib.mkOption lib.types.float 1.0;
              roundScaling = mylib.mkOption lib.types.int builtins.ceil config.scaling;
            };
          }
        )
      );
    };
  };
}
