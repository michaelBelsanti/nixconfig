{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.cosmic;
in
{
  options.desktop.cosmic.enable = mkBoolOpt false "Enable cosmic configuration.";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pwvucontrol
      overskride
      loupe
      celluloid
    ];
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
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
