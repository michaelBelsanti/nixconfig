{
  pkgs,
  mylib,
  lib,
  config,
  ...
}:
{
  options.desktops.gnome.enable = mylib.mkBool false;
  config = lib.mkIf config.desktops.gnome.enable {
    desktops.wayland = true;
    home.gtk.iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    nixos.services.xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
