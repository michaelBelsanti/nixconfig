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
    fzf
    btop
    
    # GUI Tools
    pavucontrol
    virt-manager

    # Web
    librewolf
    
    # Development
    rnix-lsp
    
    # Office
    libreoffice

    # Wine
    wineWowPackages.staging
    pkgsi686Linux.vulkan-loader
    bottles
    winetricks
    
    # Gaming
    gamescope
    vulkan-loader
    protontricks
    
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
