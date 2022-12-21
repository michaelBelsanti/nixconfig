{ pkgs, ... }: {
  home.packages = with pkgs; [
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
    (discord.override { withOpenASAR = true; nss = pkgs.nss_latest; })

    libsForQt5.qt5ct
    libsForQt5.lightly
    libsForQt5.breeze-icons

  ];
}
