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
  
  catppuccin-mocha-lavender-kvantum = with pkgs; stdenv.mkDerivation {
    name = "catppuccin-mocha-lavender-kvantum";
    version = "1.2";
    dontBuild = true;
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "Kvantum";
      rev = "04be2ad3d28156cfb62478256f33b58ee27884e9";
      sha256 = "sha256-K4RnCzH2s5J5no/S1uyv1QSpPsDs6/TRoYTjChgyxRo=";
      sparseCheckout = "src/Catppuccin-Mocha-Lavender";
    };
    installPhase = ''
      mkdir -p $out/share/Kvantum
      cp -aR $src/src/Catppuccin-Mocha-Lavender $out/share/Kvantum
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    nitch

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
    lightly-qt
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    
    # Wine
    bottles
    winetricks
    wineWowPackages.staging

    gnome.file-roller
    
    # VM
    virglrenderer

    # Custom
    # catppuccin-mocha-lavender-kvantum 
    sddm-theme.sugar-candy libsForQt5.qt5.qtquickcontrols2  libsForQt5.qt5.qtgraphicaleffects  libsForQt5.qt5.qtsvg 
  ];
}
