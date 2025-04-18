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

  nixos.always.imports = [ inputs.nixos-cosmic.nixosModules.default ];
  nixos.ifEnabled = {
    # maybe remove after Wayland Proton releases
    systemd.user = {
      services."xwayland-primary-display" = {
        script = "${lib.getExe pkgs.xorg.xrandr} --output ${host.primaryDisplay.name} --primary";
        wantedBy = [ "graphical-session.target" ];
      };
    };
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
      ])
      ++ (with inputs.nixos-cosmic.packages.${pkgs.system}; [
        andromeda
        chronos
        cosmic-ext-applet-clipboard-manager
        cosmic-ext-applet-emoji-selector
        cosmic-ext-calculator
        cosmic-ext-tweaks
        cosmic-player
        cosmic-reader
        examine
        forecast
        observatory
        tasks
      ]);
    environment.variables = {
      COSMIC_DATA_CONTROL_ENABLED = 1;
    };
  };
}
