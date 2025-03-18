{ delib, lib, ... }:
delib.module {
  name = "compat";
  myconfig.always.args.shared.compat.mkCompat =
    unstableOptions: stableOptions:
    if (lib.versionOlder lib.version "25.05pre") then stableOptions else unstableOptions;
}
