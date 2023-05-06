# These are packages that I need specifically in NixOS
# Most cli tools are installed via home-manager, so I can use them on non NixOS systems
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    helix-desktop # Helix .desktop file, so it can be the default editor
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

    # Packages distros will probably already have
    killall
    git
    file
    unrar
    unzip

    # VMs
    virt-manager
    virglrenderer

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    element-desktop
    qbittorrent
    imagemagick
    ffmpeg

    # Not in modules/gaming.nix because any device can handle retro games
    (retroarch.override {
      cores = with libretro; [
        beetle-gba
      ];
    })
  ];
}
