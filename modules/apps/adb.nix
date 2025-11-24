{ styx, den, ... }:
{
  styx.apps.provides.adb = den.lib.parametric {
    includes = [ (styx.groups "adbusers") ];
    nixos.programs.adb.enable = true;
  };
}
