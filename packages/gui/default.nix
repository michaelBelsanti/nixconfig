{ config, pkgs, ... }:
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
    
    # Wine
    bottles
    winetricks
  ];
}
