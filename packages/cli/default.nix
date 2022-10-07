{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nitch
    # Text editing
    helix

    ## CLI Tools
    git
    lazygit

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
  ];
}
