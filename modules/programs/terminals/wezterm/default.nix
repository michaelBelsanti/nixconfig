{
  pkgs,
  lib,
  config,
  mylib,
  ...
}:
let
  cfg = config.programs.wezterm;
in
{
  options.programs.wezterm = {
    enable = mylib.mkBool false;
    default = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.systemPackages = [ pkgs.wezterm ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "org.wezfurlong.wezterm.desktop" ];
    };
    home.programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
