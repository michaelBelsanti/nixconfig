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
    qbittorrent
    glow
    so
    marksman

    (retroarch.override {
      cores = with libretro; [
        beetle-gba
      ];
    })
  ];
}
