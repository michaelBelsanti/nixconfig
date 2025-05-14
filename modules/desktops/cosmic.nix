{
  unify.modules.workstation = {
    home =
      { pkgs, ... }:
      {
        xdg.configFile = {
          # using cosmics automatic gtk theming
          "gtk-4.0/assets".enable = false;
          "gtk-4.0/gtk.css".enable = false;
          "gtk-4.0/gtk-dark.css".enable = false;
        };
        gtk.iconTheme = {
          name = "Cosmic";
          package = pkgs.cosmic-icons;
        };
      };

    nixos =
      { pkgs, ... }:
      {
        services = {
          desktopManager.cosmic.enable = true;
          displayManager.cosmic-greeter.enable = true;
          gnome.gnome-keyring.enable = true;
        };
        environment.variables.COSMIC_DATA_CONTROL_ENABLED = 1;
        environment.systemPackages = with pkgs; [
          pwvucontrol
          overskride
          loupe
          celluloid
          gnome-disk-utility
          file-roller
          networkmanagerapplet
          cosmic-ext-calculator
          cosmic-ext-tweaks
          cosmic-player
          forecast
          tasks
        ];
      };
  };
}
