{
  delib,
  pkgs,
  host,
  lib,
  constants,
  ...
}:
delib.module {
  name = "desktops";
  options.desktops = {
    enable = delib.boolOption host.isWorkstation;
    wayland = delib.boolOption true;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      services.xserver = lib.mkIf (!cfg.wayland) {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
      programs = {
        dconf.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
      };
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      environment = lib.mkIf (cfg.wayland) {
        systemPackages = with pkgs; [
          wl-clipboard
          qt6.qtwayland
          wl-clipboard
        ];
        sessionVariables = lib.mkIf (cfg.wayland) {
          NIXOS_OZONE_WL = "1";
          QT_QPA_PLATFORM = "wayland;xcb";
        };
      };
    };

  home.ifEnabled = {
    gtk = {
      enable = true;
      gtk2.configLocation = "${constants.configHome}/gtk-2.0/gtkrc";
      gtk3 = {
        bookmarks = [
          "file:///home/quasi/Downloads Downloads"
          "file:///home/quasi/Documents Documents"
          "file:///home/quasi/Pictures Pictures"
          "file:///home/quasi/Videos Videos"
          "file:///home/quasi/Games Games"
        ];
      };
    };
  };
}
