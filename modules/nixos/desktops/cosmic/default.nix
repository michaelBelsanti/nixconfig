{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.cosmic;
in
{
  options.desktop.cosmic.enable = mkBoolOpt false "Enable cosmic configuration.";

  config = mkIf cfg.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    home-manager.users.${config.users.mainUser} = {
      gtk.iconTheme = {
        name = "Cosmic";
        package = pkgs.cosmic-icons;
      };
    };
  };
}
