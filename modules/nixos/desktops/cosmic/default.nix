{
  config,
  lib,
  pkgs,
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
    environment.systemPackages = with pkgs; [
      pwvucontrol
      overskride
      loupe
      celluloid
      gnome-disk-utility
      peazip
    ];
    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gtk2;
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
      gnome.gnome-keyring.enable = true;
    };
    # workaround to avoid jank when copying from terminal
    environment.variables.COSMIC_DATA_CONTROL_ENABLED = 1;
    home-manager.users.${config.users.mainUser} = {
      gtk.iconTheme = {
        name = "Cosmic";
        package = pkgs.cosmic-icons;
      };
    };
  };
}
