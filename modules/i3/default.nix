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
    (self: super: # Polybar built with i3Gaps and pulse audio support for functionality of some modules
      { polybar = super.polybar.override { i3GapsSupport = true; pulseSupport = true; }; })
    (self: super: # ibhagwan fork of polybar for nice round borders
      {
        picom = super.picom.override {
          src = fetchFromGitHub {
            owner = "jonaburg";
            repo = "picom";
            rev = "e3c19cd7d1108d114552267f302548c113278d45";
            sha256 = "sha256-Fqk6bPAOg4muxmSP+ezpGUNw6xrMWchZACKemeA08mA=";
            fetchSubmodules = true;
          };
        };
      }
    )
  ];
  environment.systemPackages = with pkgs; [
    alacritty
    polybar
    # picom
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
    xdotool
    xorg.xkill
    autotiling
    autotiling-rs
  ];
}
