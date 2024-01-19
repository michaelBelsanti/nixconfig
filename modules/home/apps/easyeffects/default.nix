{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.easyeffects;
in {
  options.apps.easyeffects.enable = mkBoolOpt false "Enable easyeffects configuration.";
  config = mkIf cfg.enable {
    services.easyeffects.enable = true;
    xdg.configFile."easyeffects" = {
      source = ./config;
      recursive = true;
    };
    home.packages = with pkgs; [
      (writeShellScriptBin "eerestart" ''
        pkill easyeffects
        sleep .5
        easyeffects --gapplication-service &
      '')
    ];
  };
}
