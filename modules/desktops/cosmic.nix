{
  unify.modules.cosmic = {
    home =
      { pkgs, lib, ... }:
      {
        services.vicinae.useLayerShell = false;
        xdg.configFile = {
          # using cosmics automatic gtk theming
          "gtk-4.0/assets".enable = false;
          "gtk-4.0/gtk.css".enable = false;
          "gtk-4.0/gtk-dark.css".enable = false;
        };
        gtk.iconTheme = {
          name = lib.mkForce "Cosmic";
          package = lib.mkForce pkgs.cosmic-icons;
        };
      };

    nixos =
      { pkgs, lib, ... }:
      {
        nixpkgs.overlays = [
          (self: super: {
            cosmic-session = super.cosmic-session.overrideAttrs (
              final: prev: {
                postPatch = ''
                  substituteInPlace data/start-cosmic \
                    --replace-fail '/usr/bin/cosmic-session' "${placeholder "out"}/bin/cosmic-session" \
                    --replace-fail '/usr/bin/dbus-run-session' "${lib.getBin pkgs.dbus}/bin/dbus-run-session" \
                    --replace-fail 'systemctl --user import-environment ' 'dbus-update-activation-environment --verbose --all --systemd || systemctl --user import-environment #'
                  substituteInPlace data/cosmic.desktop \
                    --replace-fail '/usr/bin/start-cosmic' "${placeholder "out"}/bin/start-cosmic"
                '';
              }
            );
            networkmanagerapplet = super.networkmanagerapplet.overrideAttrs {
              patches = (
                super.fetchpatch {
                  url = "https://github.com/pop-os/network-manager-applet/commit/8af78f7ebfa770f24cf46693cb215c5c22dbacfb.patch";
                  hash = "sha256-Q9oB6s2LDuzoj1jQbC+EARL9CguoacLAdeSlx+KQ+Yw=";
                }
              );
            };
          })
        ];
        xdg.portal.xdgOpenUsePortal = true;
        services = {
          desktopManager.cosmic.enable = true;
          displayManager.cosmic-greeter.enable = true;
          gnome.gnome-keyring.enable = true;
          geoclue2.enable = true; # expected by cosmic-settings-daemon, shutdown hangs without it
          geoclue2.enableDemoAgent = false;
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
