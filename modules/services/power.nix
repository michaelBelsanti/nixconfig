{
  mylib,
  config,
  lib,
  ...
}:
{
  options.services.power.enable = mylib.mkEnabledIf "laptop";
  config.nixos.services = lib.mkIf config.services.power.enable {
    services.power-profiles-daemon.enable = false;
    hardware.system76.power-daemon.enable = true;
    services.thermald.enable = true;
  };
}
