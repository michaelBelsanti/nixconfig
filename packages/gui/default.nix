{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    librewolf
    libreoffice
    pavucontrol
    virt-manager

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    cider
    element-desktop
    celluloid
    qbittorrent
    discord-canary
    spotify-qt
    spotifywm
    
    # Wine
    bottles
    winetricks
    wineWowPackages.staging

    gnome.file-roller
  ];
}
