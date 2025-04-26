{
  config,
  pkgs,
  lib,
  mylib,
  constants,
  ...
}:
let
  cfg = config.desktops;
in
{
  options.desktops = {
    enable = mylib.mkEnabledIf "workstation";
    wayland = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
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
      environment = lib.mkIf cfg.wayland {
        systemPackages = [ pkgs.wl-clipboard ];
        sessionVariables.NIXOS_OZONE_WL = "1";
      };
    };

    home = {
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
  };
}
