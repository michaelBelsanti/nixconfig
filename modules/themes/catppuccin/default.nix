# Imported by home-manager,
# Sets catppuccin theming for any apps that can easily have their theming seperated from the rest of the config
{ pkgs, ... }: {
  gtk = {
    theme = {
      name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "macchiato";
      };
    };
    gtk3.extraCss = ''
      decoration, window, window.background, window.titlebar, * {
        border-radius: 0px;
      }
    ''; # Fixes bugged context menus
  };
  home.file.".background-image".source = ./background.png;
  xdg.dataFile."konsole/Catppuccin.colorscheme".source = ./Catppuccin-Macchiato.colorscheme;
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
    gitui.theme = ''
      (
          selected_tab: Reset,
          command_fg: Rgb(202, 211, 245),
          selection_bg: Rgb(91, 96, 120),
          selection_fg: Rgb(202, 211, 245),
          cmdbar_bg: Rgb(30, 32, 48),
          cmdbar_extra_lines_bg: Rgb(30, 32, 48),
          disabled_fg: Rgb(128, 135, 162),
          diff_line_add: Rgb(166, 218, 149),
          diff_line_delete: Rgb(237, 135, 150),
          diff_file_added: Rgb(238, 212, 159),
          diff_file_removed: Rgb(238, 153, 160),
          diff_file_moved: Rgb(198, 160, 246),
          diff_file_modified: Rgb(245, 169, 127),
          commit_hash: Rgb(183, 189, 248),
          commit_time: Rgb(184, 192, 224),
          commit_author: Rgb(125, 196, 228),
          danger_fg: Rgb(237, 135, 150),
          push_gauge_bg: Rgb(138, 173, 244),
          push_gauge_fg: Rgb(36, 39, 58),
          tag_fg: Rgb(244, 219, 214),
          branch_fg: Rgb(139, 213, 202)
      )
    '';
  };
}
