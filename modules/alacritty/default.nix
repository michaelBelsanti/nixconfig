{ config, pkgs, ...}:
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    env.TERM = "xterm-256color";
    font = {
      normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "JetBrainsMono Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "JetBrainsMono Nerd Font";
        style = "Italic";
      };
      bold_italic = {
        family = "JetBrainsMono Nerd Font";
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
}
