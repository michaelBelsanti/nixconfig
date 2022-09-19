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
    btop
    ncdu
    edir
    gdu
    clifm
    aria2
    
    # Development
    rnix-lsp
    lldb
  ];
}
