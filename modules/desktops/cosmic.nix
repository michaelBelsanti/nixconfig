{
  delib,
  lib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktops.cosmic";
  options = delib.singleEnableOption true;
  myconfig.ifEnabled.desktops.wayland.enable = true;

  home.ifEnabled = {
    # avoid bug with cosmic deleting gtk.css file
    xdg.configFile."gtk-4.0/gtk.css".enable = false;
    gtk = {
      # Cosmic can make libadwaita apps follow the cosmic theme, so make gtk3 follow libadwaita
      # mkForce because my theming modules set these
      theme = lib.mkForce {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = "Cosmic";
        package = pkgs.cosmic-icons;
      };
    };
  };

  nixos.always.imports = [ inputs.nixos-cosmic.nixosModules.default ];
  nixos.ifEnabled = {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      gnome.gnome-keyring.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = 1;
    environment.systemPackages =
      (with pkgs; [
        pwvucontrol
        overskride
        loupe
        celluloid
        gnome-disk-utility
        peazip
      ])
      ++ (with inputs.nixos-cosmic.packages.${pkgs.system}; [
        chronos
        cosmic-ext-tweaks
        cosmic-ext-forecast
        cosmic-ext-tasks
        cosmic-ext-applet-emoji-selector
        cosmic-ext-applet-clipboard-manager
        cosmic-ext-calculator
        cosmic-ext-examine
        cosmic-ext-observatory
        cosmic-reader
        cosmic-player
      ]);
    environment.variables = {
      COSMIC_DISABLE_DIRECT_SCANOUT = 1; # fix crashes with maximized firefox
      COSMIC_DATA_CONTROL_ENABLED = 1;
    };
  };
}
