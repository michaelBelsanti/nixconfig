{
  styx.power-mgmt.nixos.services = {
    tuned.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false;
  };
}
