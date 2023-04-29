{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    helix-desktop # Helix .desktop file (uses wezterm)
    librewolf
    libreoffice
    discord-canary
    xwaylandvideobridge

    # Editor
    helix

    # Nix
    nix-alien

    # Containers
    distrobox
    podman-compose

    # NFS
    nfs-utils

    virt-manager
    virglrenderer

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    element-desktop
    qbittorrent

    (retroarch.override {
      cores = with libretro; [
        beetle-gba
      ];
    })
  ];
}
