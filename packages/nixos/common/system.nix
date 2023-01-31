{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    librewolf
    # libreoffice

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
    # nix-alien
    devenv

    distrobox

    so

    discord
  ];
}
