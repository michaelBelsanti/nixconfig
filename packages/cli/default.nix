{ config, pkgs, ... }:
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

    wget
    aria2
    unrar
    unzip
    killall
    bat
    tldr
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

    # Process managers
    btop
    bottom

    # Nix
    rnix-lsp
    nix-tree
    nix-template
    nix-index
    
    distrobox
  ];
}
