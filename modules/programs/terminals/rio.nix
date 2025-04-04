{
  unify,
  pkgs,
  lib,
  ...
}:
unify.module {
  name = "programs.rio";
  options.programs.rio = with unify; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.systemPackages = [ pkgs.rio ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "rio.desktop" ];
    };
  home.ifEnabled = {
    programs.rio = {
      enable = true;
      settings = {
        window.decorations = "Disabled";
        fonts = {
          size = 18;
        };
        keyboard.use-kitty-keyboard-protocol = true;
      };
    };
  };
}
