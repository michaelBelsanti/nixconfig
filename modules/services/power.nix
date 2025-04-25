{ delib, host, ... }:
delib.module {
  name = "services.power";
  options = delib.singleEnableOption host.isLaptop;

  nixos.ifEnabled = {
    services.power-profiles-daemon.enable = false;
    hardware.system76.power-daemon.enable = true;
    services.thermald.enable = true;
  };
}
