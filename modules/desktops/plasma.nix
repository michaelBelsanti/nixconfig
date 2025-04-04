{ unify, pkgs, ... }:
unify.module {
  name = "desktops.plasma";
  options = unify.singleEnableOption false;
  myconfig.ifEnabled.desktops.wayland = true;

  home.ifEnabled = {
    gtk = {
      iconTheme = {
        name = "Breeze";
        package = pkgs.kdePackages.breeze-icons;
      };
    };
  };

  nixos.ifEnabled = {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
  };
}
