{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.wezterm";
  options.programs.wezterm = with delib; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.systemPackages = [ pkgs.wezterm ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "org.wezfurlong.wezterm.desktop" ];
    };
  home.ifEnabled = {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
