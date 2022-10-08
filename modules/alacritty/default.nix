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

    colors = {
      primary = {
        foreground = "0xD9E0EE";
        background = "0x1E1D2F";
      };
      cursor = {
        text = "0x1E1D2F";
        cursor = "0xF5E0DC";
      };
      normal = {      
        black =   "0x6E6C7E";
        red =     "0xF28FAD";
        green =   "0xABE9B3";
        yellow =  "0xFAE3B0";
        blue =    "0x96CDFB";
        magenta = "0xF5C2E7";
        cyan =    "0x89DCEB";
        white =   "0xD9E0EE";
      };
      bright = {
        black =   "0x988BA2";
        red =     "0xF28FAD";
        green =   "0xABE9B3";
        yellow =  "0xFAE3B0";
        blue =    "0x96CDFB";
        magenta = "0xF5C2E7";
        cyan =    "0x89DCEB";
        white =   "0xD9E0EE";
      };
      indexed_colors = [
        {
          index = 16;
          color = "0xF8BD96";
        }
        {
          index = 17;
          color = "0xF5E0DC";
        }
      ];
    };
    key-bindings = [
      {
        key = "Return";
        mods = "Control";
        action = "SpawnNewInstance";
      }
    ];
  };
  # xdg.configFile."alacritty" = {
  #   source = ./config;
  #   recursive = true;
  # };
}
