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
    jellyfin-media-player
    mullvad-vpn
    wmctrl
    tetrio-desktop
    selectdefaultapplication
    easyeffects
    cider
    nim
    element-desktop
    nsxiv
    celluloid
    grapejuice
    lxsession
    qbittorrent
    
    # Programming
    lldb
    
    ## Rust
    rustup
    rust-analyzer
    
    ## Java
    eclipses.eclipse-java
    jetbrains.idea-community
    jetbrains.jdk
    staruml
  ];
}
