{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Text editing
    helix
    vim
    
    # CLI Tools
    wget
    git
    unrar
    unzip
    gamemode
    killall
    tldr
    lsof
    dig 
    fd
    ripgrep
    pamixer
    bat
    
    # GUI Tools
    pavucontrol
    virt-manager

    # Web
    librewolf
    discord
    
    # Development
    rnix-lsp
    
    # Office
    libreoffice

    # Wine
    wineWowPackages.staging
    # pkgsi686Linux.vulkan-loader
    bottles
    
    # Gaming
    gamescope
    vulkan-loader
    
    # JC dependencies
    dwarfs
    fuse-overlayfs
    aria2
  ];
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    montserrat
  ];
}
