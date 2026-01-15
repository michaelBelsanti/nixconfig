{
  styx.power-mgmt.nixos.services = {
    upower.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
  };
}
