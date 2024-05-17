{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.alacritty;
in
{
  options.apps.alacritty.enable = mkBoolOpt false "Enable alacritty configuration.";
  config = mkIf cfg.enable {
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
}
