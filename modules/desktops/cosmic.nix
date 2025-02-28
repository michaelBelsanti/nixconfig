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
    # maybe remove after Wayland Proton releases
    systemd.user = {
      services."wl-x11-clipsync" = {
        script = "${lib.getExe pkgs.xorg.xrandr} --output ${host.primaryDisplay.name} --primary";
        wantedBy = [ "graphical-session.target" ];
      };
      services."sync-wayland-xwayland-clipboard" =
        let
          clipsync = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/arabianq/wl-x11-clipsync/fc3ac4d1d57ffdc3222e818c8a58d20c91f3fcf3/clipsync.py";
            hash = "sha256-0ZxgSKTRHUTGAzzJeCh+gCThn308pRdadW6xyNId8CE=";
          };
        in
        {
          path = with pkgs; [
            python3
            wl-clipboard
            xclip
            clipnotify
            which
          ];
          script = "python ${clipsync}";
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
