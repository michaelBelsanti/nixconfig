{ config, lib, ... }:
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
  };
}
