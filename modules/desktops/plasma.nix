{
  pkgs,
  mylib,
  lib,
  config,
  ...
}:
{
  options.desktops.plasma.enable = mylib.mkBool false;
  config = lib.mkIf config.desktops.plasma.enable {
    desktops.wayland = true;
    home.gtk.iconTheme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-icons;
    };

    nixos.services = {
      desktopManager.plasma6.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
  };
}
