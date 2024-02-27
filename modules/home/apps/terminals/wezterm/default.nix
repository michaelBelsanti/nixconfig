{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.wezterm;
in {
  options.apps.wezterm.enable = mkBoolOpt false "Enable wezterm configuration.";
  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
