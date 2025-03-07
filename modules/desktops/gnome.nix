{ delib, pkgs, ... }:
delib.module {
  name = "desktops.gnome";
  options = delib.singleEnableOption false;
  myconfig.ifEnabled.desktops.wayland = true;

  home.ifEnabled = {
    gtk = {
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };
  };

  nixos.ifEnabled = {
    services.xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
