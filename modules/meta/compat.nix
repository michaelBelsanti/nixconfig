{ lib, ... }:
{
  _module.args.mkCompat =
    unstableOptions: stableOptions:
    if (lib.versionOlder lib.version "25.05pre") then stableOptions else unstableOptions;
}
