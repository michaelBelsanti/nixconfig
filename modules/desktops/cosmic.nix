{
  delib,
  lib,
  pkgs,
  inputs,
  host,
  ...
}:
delib.module {
  name = "desktops.cosmic";
  options = delib.singleEnableOption host.isWorkstation;
  myconfig.ifEnabled.desktops.wayland = true;

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
        package = inputs.nixos-cosmic.packages.${pkgs.system}.cosmic-icons;
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
    environment.systemPackages =
      (with pkgs; [
        pwvucontrol
        overskride
        loupe
        celluloid
        gnome-disk-utility
        file-roller
      ])
      ++ (with inputs.nixos-cosmic.packages.${pkgs.system}; [
        cosmic-reader
        cosmic-player
        tasks
        chronos
        examine
        forecast
        observatory
        cosmic-ext-applet-emoji-selector
        cosmic-ext-applet-clipboard-manager
        cosmic-ext-calculator
        cosmic-ext-tweaks
      ]);
    environment.variables = {
      COSMIC_DATA_CONTROL_ENABLED = 1;
    };
  };
}
