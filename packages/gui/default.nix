{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
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
    
    # Wine
    bottles
    winetricks
    
    # Theming
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins 
    libsForQt5.lightly
    lightly-qt
    
    gnome.file-roller
  ];
  # Uniform qt theming
  qt5 = {
    enable = true;
    # style = "kvantum"; # why doesn't this exist?
    platformTheme = "qt5ct";
  };
  environment.variables = lib.mkForce {
    QT_STYLE_OVERRIDE = "kvantum";
    XCURSOR_THEME = "phinger-cursors";
  };
}
