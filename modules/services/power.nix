{ unify, host, ... }:
unify.module {
  name = "services.power";
  options = unify.singleEnableOption host.isLaptop;

  nixos.ifEnabled.services = {
    thermald.enable = true;
    power-profiles-daemon.enable = true;
  };
}
