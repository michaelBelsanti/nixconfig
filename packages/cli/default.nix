{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Text editing
    helix wl-clipboard xclip
    
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
    clifm
    aria2
    du-dust
    
    # Development
    rnix-lsp
    lldb
  ];
}
