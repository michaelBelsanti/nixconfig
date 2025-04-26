{
  mylib,
  config,
  lib,
  ...
}:
{
  options.services.power.enable = mylib.mkEnabledIf "laptop";
  config.nixos.services = lib.mkIf config.services.power.enable {
    thermald.enable = true;
    power-profiles-daemon.enable = true;
  };
}
