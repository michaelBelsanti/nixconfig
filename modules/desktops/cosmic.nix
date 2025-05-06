{ inputs, ... }:
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
          package = inputs.nixos-cosmic.packages.${pkgs.system}.cosmic-icons;
        };
      };

    nixos =
      { pkgs, ... }:
      {
        # maybe remove after Wayland Proton releases
        # systemd.user = {
        #   services."xwayland-primary-display" = {
        #     script = "${lib.getExe pkgs.xorg.xrandr} --output ${
        #       config.host.${hostname}.primaryDisplay.name
        #     } --primary";
        #     wantedBy = [ "graphical-session.target" ];
        #   };
        # };
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
            networkmanagerapplet
            cosmic-ext-calculator
            cosmic-ext-tweaks
            cosmic-player
            forecast
            tasks
          ])
          ++ (with inputs.nixos-cosmic.packages.${pkgs.system}; [
            andromeda
            examine
            observatory
          ]);
        environment.variables = {
          COSMIC_DATA_CONTROL_ENABLED = 1;
        };
      };
  };
}
