{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    polybar
    picom
    betterlockscreen
    i3status
    shotgun
    hacksaw
    rofi
    feh
    nitrogen
    sxhkd
    cinnamon.nemo
    clifm
    jetbrains.idea-community
    jetbrains.jdk
    jellyfin-media-player
    mullvad-vpn
    wmctrl
    tetrio-desktop
    selectdefaultapplication
    easyeffects
    cider
    nim
    element-desktop
    nsxiv
    celluloid
    grapejuice
    lxsession
    qbittorrent
    
    # Programming
    lldb
    
    ## Rust
    rustup
    rust-analyzer
    # vscode-extensions.vadimcn.vscode-lldb
  ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      vadimcn.vscode-lldb
    ];
  };

}
