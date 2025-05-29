{
  unify.modules.workstation = {
    nixos =
      { pkgs, ... }:
      {
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
        environment = {
          systemPackages = [ pkgs.wl-clipboard ];
          sessionVariables.NIXOS_OZONE_WL = "1";
        };
      };

    home =
      { config, ... }:
      {
        qt.enable = true;
        gtk = {
          enable = true;
          gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
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
