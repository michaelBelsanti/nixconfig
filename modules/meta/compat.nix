{
  unify =
    let
      mkMkCompat =
        lib: unstableOptions: stableOptions:
        if (lib.versionOlder lib.version "25.11pre") then stableOptions else unstableOptions;
    in
    {
      nixos =
        { lib, ... }:
        {
          _module.args.mkCompat = mkMkCompat lib;
        };
      home =
        { lib, ... }:
        {
          _module.args.mkCompat = mkMkCompat lib;
        };
    };
}
