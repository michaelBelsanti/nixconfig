{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix-desktop # Helix .desktop file (uses wezterm)
    nitch
    lazygit
    distrobox
    devenv

    virt-manager
    virglrenderer

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    element-desktop
    celluloid
    qbittorrent
    discord-openasar
    spotify

    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    jflap
  ];
}
