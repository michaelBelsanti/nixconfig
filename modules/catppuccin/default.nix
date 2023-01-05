# Imported by home-manager, sets catppuccin system theming
{ pkgs, ... }: {
  gtk = {
    theme = {
      name = "Catppuccin-Pink-Dark";
      package = pkgs.catppuccin-gtk;
    };
    gtk3.extraCss = ''
      decoration, window, window.background, window.titlebar, * {
        border-radius: 0px;
      }
    ''; # Fixes bugged context menus
  };
  home.file.".background-image".source = ../../etc/bg.png;
  xdg.configFile = {
    # Libadwaita theme
    "gtk-4.0/gtk.css".source = ./gtk.css;
    "qt5ct" = {
      recursive = true;
      source = ./qt5ct;
    };
  };
  programs = {
    spicetify.theme = pkgs.spicePkgs.themes.catppuccin-mocha;
    helix.settings.theme = "catppuccin_macchiato";
    alacritty.settings = {
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
          black = "0x6E6C7E";
          red = "0xF28FAD";
          green = "0xABE9B3";
          yellow = "0xFAE3B0";
          blue = "0x96CDFB";
          magenta = "0xF5C2E7";
          cyan = "0x89DCEB";
          white = "0xD9E0EE";
        };
        bright = {
          black = "0x988BA2";
          red = "0xF28FAD";
          green = "0xABE9B3";
          yellow = "0xFAE3B0";
          blue = "0x96CDFB";
          magenta = "0xF5C2E7";
          cyan = "0x89DCEB";
          white = "0xD9E0EE";
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
    };
    mako = {
      backgroundColor = "#1e1e2e";
      borderColor = "#89b4fa";
      textColor = "#cdd6f4";
      progressColor = "#313244";
      extraConfig = ''
        [urgency=high]
        border-color=#fab387
      '';
    };
  };
}
