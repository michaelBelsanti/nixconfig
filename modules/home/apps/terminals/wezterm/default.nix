{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.wezterm;
in
{
  options.apps.wezterm.enable = mkBoolOpt false "Enable wezterm configuration.";
  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm-nightly;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
