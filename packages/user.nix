{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    polybar
    picom
    betterlockscreen
    i3status
    shotgun
    hacksaw
    rofi
    feh
    nitrogen
    sxhkd
    cinnamon.nemo
    clifm
    jetbrains.idea-community
    jetbrains.jdk
    jellyfin-media-player
    mullvad-vpn
    wmctrl
    tetrio-desktop
    selectdefaultapplication
    easyeffects
    cider
    nim
    # grapejuice
    lxsession
  ];
}
