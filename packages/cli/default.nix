{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
    btop
    ncdu
    edir
    gdu
    clifm
    
    # Development
    rnix-lsp
    lldb
    
    # Wine
    wineWowPackages.staging
  ];
}
