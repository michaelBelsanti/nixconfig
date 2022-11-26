{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    nitch
    # Text editing
    helix
    neovim

    ## CLI Tools
    git
    lazygit

    cachix

    aria2
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
    # clifm
    gdu
    du-dust
    lf

    # Process managers
    btop
    bottom

    # Nix
    rnix-lsp
    nix-tree
    nix-template
    nix-index
    
    distrobox
    
    devenv
  ];
}
