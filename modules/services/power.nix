{
  unify.modules.laptop.nixos.services = {
    services.power-profiles-daemon.enable = false;
    hardware.system76.power-daemon.enable = true;
    services.thermald.enable = true;
  };
}
