{
  pkgs,
  lib,
  mylib,
  config,
  ...
}:
let
  cfg = config.programs.rio;
in
{
  options.programs.rio = {
    enable = mylib.mkBool false;
    default = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.systemPackages = [ pkgs.rio ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "rio.desktop" ];
    };
    home = {
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
  };
}
