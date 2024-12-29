# These are packages that I need specifically in NixOS
# Most cli tools are installed via home-manager, so I can use them on non NixOS systems
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zen-browser
    firefox
    libreoffice
    hunspell
    hunspellDicts.en_US-large
    vesktop
    kdenlive
    remmina
    bottles
    wl-clipboard
    # custom.affine
    localsend
    tidal-hifi
    varia
    # quickemu
    proton-pass
    zotero

    (python3.withPackages (python-pkgs: [
      python-pkgs.pandas
      python-pkgs.requests
    ]))

    input-leap

    # Editor
    helix
    (pkgs.buildFHSEnv {
      name = "zed";
      targetPkgs =
        pkgs: with pkgs; [
          zed-editor
        ];
      runScript = "zed";
    })

    # Containers
    distrobox
    podman-compose

    # NFS
    nfs-utils

    # Packages distros will probably already have
    file
    git
    gptfdisk
    killall
    unrar
    unzip
    wget

    jellyfin-media-player
    protonvpn-gui
    tetrio-desktop
    element-desktop
    imagemagick
    ffmpeg
    filelight
    gnome-frog
    pomodoro
    wike

    # Not in modules/gaming.nix because any device can handle retro games
    retroarch-full

    doas-sudo-shim
  ];
}
