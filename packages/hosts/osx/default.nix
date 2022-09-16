{ config, pkgs, ... }:
{
  imports = [
    ../../programming/rust
  ];
  
  environment.systemPackages = with pkgs; [
    # Text editing
    helix
    
    # CLI Tools
    wget
    git
    unrar
    fd
    ripgrep
    bat
    fzf
    btop
    ncdu
    edir
    gdu
    tldr
    
    # Development
    rnix-lsp
    lldb
    
    jdk11
  ];
}
