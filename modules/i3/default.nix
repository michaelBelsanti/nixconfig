{ lib, config, pkgs, ... }:
{
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    # displayManager.defaultSession = "none+i3";
  };
}
