{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    librewolf
    libreoffice-qt
    discord

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
    dog
    lnav

    # Networking
    traceroute
    whois
    nmap

    # File Management
    edir
    clifm
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
    devenv

    # Containers
    distrobox
  ];
}
