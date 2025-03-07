{ delib, pkgs, ... }:
delib.module {
  name = "desktops.plasma";
  options = delib.singleEnableOption false;
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
      displayManager.sddm.enable = true;
    };
  };
}
