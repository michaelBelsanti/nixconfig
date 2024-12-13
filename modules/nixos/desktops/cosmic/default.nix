{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.cosmic;
in
{
  options.desktop.cosmic.enable = mkBoolOpt false "Enable cosmic configuration.";
  config = mkIf cfg.enable {
    desktop.wayland.enable = true;
    # avoid bug with cosmic deleting gtk.css file
    snowfallorg.users.${config.users.mainUser}.home.config = {
      xdg.configFile."gtk-4.0/gtk.css".enable = false;
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
    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gtk2;
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      gnome.gnome-keyring.enable = true;
    };
    # workaround to avoid jank when copying from terminal
    environment.variables = {
      COSMIC_DISABLE_DIRECT_SCANOUT = 1; # fix crashes with maximized firefox
      COSMIC_DATA_CONTROL_ENABLED = 1;
    };
    home-manager.users.${config.users.mainUser} = {
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
  };
}
