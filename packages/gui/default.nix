{ config, pkgs, lib, ... }:
let 
  helix-desktop = pkgs.makeDesktopItem {
    name = "helix";
    desktopName = "Helix (TUI)";
    genericName = "Helix";
    exec = "wezterm start hx %F";
    mimeTypes = [ "text/plain" "inode/directory" ];
    categories = [ "Utility" "TextEditor" "Development" ];
  };
in
{
  environment.systemPackages = with pkgs; [
    helix-desktop
    
    networkmanagerapplet
    
    librewolf
    libreoffice
    pavucontrol
    virt-manager

    jellyfin-media-player
    mullvad-vpn
    tetrio-desktop
    easyeffects
    element-desktop
    celluloid
    qbittorrent
    discord-openasar
    spotify
    spicetify-cli
    
    # Theming
    # lightly-qt
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    gnome.file-roller
    
    # VM
    virglrenderer

    # Custom
    # catppuccin-mocha-lavender-kvantum 
    # sddm-theme.sugar-candy libsForQt5.qt5.qtquickcontrols2  libsForQt5.qt5.qtgraphicaleffects  libsForQt5.qt5.qtsvg 

    jflap
  ];
}
