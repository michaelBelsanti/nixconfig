{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # nitch
    # Text editing
    helix
    
    # CLI Tools
    wget
    git
    unrar
    unzip
    killall
    tldr
    lsof
    dig 
    fd
    ripgrep
    pamixer
    bat
    fzf
    btop bottom
    ncdu
    edir
    gdu
    # clifm
    aria2
    du-dust
    bottom
    
    # Nix
    rnix-lsp
  ];
}
