{
  pkgs,
  lib,
  mylib,
  config,
  ...
}:
let
  cfg = config.programs.alacritty;
in
{
  options.programs.alacritty = {
    enable = mylib.mkBool false;
    default = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.systemPackages = [ pkgs.alacritty ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "Alacritty.desktop" ];
    };
    home = {
      programs.alacritty.enable = true;
      programs.alacritty.settings = {
        env.TERM = "xterm-256color";
        font = {
          normal = {
            family = "monospace";
            style = "Regular";
          };
          bold = {
            family = "monospace";
            style = "Bold";
          };
          italic = {
            family = "monospace";
            style = "Italic";
          };
          bold_italic = {
            family = "monospace";
            style = "Bold Italic";
          };
          size = 12;
          offset.x = 0;
          offset.y = 1;
        };

        window.padding = {
          x = 4;
          y = 4;
        };
        key-bindings = [
          {
            key = "Return";
            mods = "Control";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
  };
}
