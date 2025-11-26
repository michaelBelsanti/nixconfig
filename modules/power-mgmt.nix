{
  styx.power-mgmt.nixos.services = {
    tuned.enable = true;
    thermald.enable = true;
    tlp.enable = false;
    power-profiles-daemon.enable = false;
  };
}
