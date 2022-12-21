{ lib, config, pkgs, ... }:
{
config = lib.mkIf (config.services.xserver.windowManager.i3.enable || config.programs.hyprland.enable) {
    environment.systemPackages = with pkgs; [
      wezterm
      dolphin
      libsForQt5.ark
      wmctrl
      selectdefaultapplication
      (polkit_gnome.overrideAttrs (_oldAttrs: {
        postFixup = ''
          mkdir $out/bin
          ln -s $out/libexec/polkit-gnome-authentication-agent-1 $out/bin/polkit-gnome
        '';
      }))
      nsxiv
      pamixer
      networkmanagerapplet
      pavucontrol

      libsForQt5.qt5ct
      libsForQt5.lightly
      libsForQt5.breeze-icons
    ];
  };
}
