{
  styx.power-management.nixos = {
    services.power-profiles-daemon.enable = false;
    hardware.system76.power-daemon.enable = true;
    services.thermald.enable = true;
  };
}
