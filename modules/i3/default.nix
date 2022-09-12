{ lib, config, pkgs, ... }:
{
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    # displayManager.defaultSession = "none+i3";
  };
  
  nixpkgs.overlays = [
    (self: super:
      { polybar = super.polybar.override { i3GapsSupport = true; pulseSupport = true; }; })
  ];
  environment.systemPackages = with pkgs; [
    alacritty
    polybar
    picom
    betterlockscreen
    shotgun
    hacksaw
    rofi
    feh
    cinnamon.nemo
    wmctrl
    selectdefaultapplication
    lxsession
    nsxiv
    pamixer
  }
}
