{ unify, pkgs, ... }:
unify.module {
  name = "desktops.gnome";
  options = unify.singleEnableOption false;
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
