{ lib, config, pkgs, fetchFromGitHub, ... }:
{
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    # displayManager.defaultSession = "none+i3";
  };

  environment.systemPackages = with pkgs; [
    wezterm
    alacritty
    betterlockscreen
    shotgun
    hacksaw
    rofi
    feh
    dunst
    cinnamon.nemo
    wmctrl
    selectdefaultapplication
    lxsession
    nsxiv
    pamixer
    xdotool
    xorg.xkill
    xclip
    pamixer

    autotiling
    # autotiling-rs # Has not worked for me

    (polybar.override { i3GapsSupport = true; pulseSupport = true; })
    (picom.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchFromGitHub {
        owner = "jonaburg";
        repo = "picom";
        rev = "e3c19cd7d1108d114552267f302548c113278d45";
        sha256 = "sha256-Fqk6bPAOg4muxmSP+ezpGUNw6xrMWchZACKemeA08mA=";
        fetchSubmodules = true;
      };
    }))
  ];
}
