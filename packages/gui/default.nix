{ config, pkgs, lib, ... }:
let 
  helix-desktop = pkgs.makeDesktopItem {
    name = "helix";
    desktopName = "Helix (TUI)";
    genericName = "Helix";
    exec = "alacritty -e hx %F";
    mimeTypes = [ "text/plain" "inode/directory" ];
    categories = [ "Utility" "TextEditor" "Development" ];
  };
  
  sddm-theme = pkgs.callPackage ./custom.nix { };
  
in
{
  environment.systemPackages = with pkgs; [
    helix-desktop
    
    librewolf
    libreoffice
    pavucontrol
    virt-manager

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    cider
    element-desktop
    celluloid
    qbittorrent
    discord-canary
    spotify
    
    # Theming
    libsForQt5.qtstyleplugin-kvantum
    
    # Wine
    bottles
    winetricks
    wineWowPackages.staging

    gnome.file-roller

    # Custom
    sddm-theme.sugar-candy libsForQt5.qt5.qtquickcontrols2  libsForQt5.qt5.qtgraphicaleffects  libsForQt5.qt5.qtsvg 
  ];
}
