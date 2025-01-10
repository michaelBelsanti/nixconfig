{delib, host, ...}:
delib.module {
  name = "power";
  options = delib.singleEnableOption host.isLaptop;

  nixos.ifEnabled.services = {
    thermald.enable = true;
    power-profiles-daemon.enable = true;
  };
}
