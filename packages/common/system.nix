{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    librewolf
    libreoffice
    discord
    xwaylandvideobridge

    # Text editing
    helix
    neovim

    ## CLI Tools
    git
    cachix
    aria2
    ouch
    unrar
    unzip
    killall
    bat
    tealdeer
    lsof
    dig
    fd
    ripgrep
    fzf
    ncdu
    imagemagick
    edir
    dogdns
    lnav
    file
    xxd

    # Networking
    traceroute
    whois
    nmap

    # File Management
    edir
    gdu
    du-dust
    lf

    # Process managers
    bottom

    # Nix
    nil
    nurl
    nix-tree
    nix-index
    nix-alien

    # Containers
    distrobox
    podman-compose

    # NFS
    nfs-utils

  ];
}
