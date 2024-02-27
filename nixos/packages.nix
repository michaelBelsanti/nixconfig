# These are packages that I need specifically in NixOS
# Most cli tools are installed via home-manager, so I can use them on non NixOS systems
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    helix-desktop # Helix .desktop file, so it can be the default editor
    logseq
    libreoffice
    vesktop
    revolt-desktop
    spotify
    xwaylandvideobridge
    kdenlive
    signal-desktop
    bitwarden
    rbw
    mumble
    remmina
    nextcloud-client
    bottles
    beeper
    spot
    newsflash
    wl-clipboard
    floorp

    (python3.withPackages (python-pkgs: [
      python-pkgs.pandas
      python-pkgs.requests
    ]))

    input-leap

    # Editor
    helix

    # Nix
    nix-alien
    nix-output-monitor
    nixpkgs-review

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
    gptfdisk
    wget

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    element-desktop
    fractal
    qbittorrent
    imagemagick
    ffmpeg
    filelight
    gnome-frog

    # Not in modules/gaming.nix because any device can handle retro games
    (retroarch.override {
      cores = with libretro; [
        beetle-gba
      ];
    })

    doas-sudo-shim
  ];
}
