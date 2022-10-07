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
    alacritty
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
    xclip
    pamixer

    autotiling
    # autotiling-rs # Has not worked for me

    (polybar.override { i3GapsSupport = true; pulseSupport = true; }; 
    (picom.override {
      src = fetchFromGitHub {
        owner = "jonaburg";
        repo = "picom";
        rev = "e3c19cd7d1108d114552267f302548c113278d45";
        sha256 = "sha256-Fqk6bPAOg4muxmSP+ezpGUNw6xrMWchZACKemeA08mA=";
        fetchSubmodules = true;
      };
    })
  ];

  # Good defaults for standalone apps
  # xdg.mime.defaultApplications = {
    # application/pdf = "librewolf.desktop";
    # x-scheme-handler/http = "librewolf.desktop"
    # x-scheme-handler/https = "librewolf.desktop"
  # }
}
