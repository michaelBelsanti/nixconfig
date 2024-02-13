# Imported by home-manager,
# Sets catppuccin theming for any apps that can easily have their theming seperated from the rest of the config
{
  lib,
  pkgs,
  config,
  ...
}: let
  wallpaper = ./background_upscaled.png;
  capitalizeFirstLetter = str: let
    firstLetter = builtins.substring 0 1 str;
    restOfString = builtins.substring 1 (builtins.stringLength str) str;
  in
    builtins.concatStringsSep "" [(lib.strings.toUpper firstLetter) restOfString];
  catppuccinEnabled = config.theming.enable && (config.theming.theme == "catppuccin");
  flavour = config.theming.variant;
  accent = config.theming.accent;
  Flavour = capitalizeFirstLetter config.theming.variant;
  Accent = capitalizeFirstLetter config.theming.accent;
in {
  config = lib.mkIf catppuccinEnabled {
    gtk = {
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
      theme = {
        name = "Catppuccin-${Flavour}-Standard-${Accent}-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["${accent}"];
          variant = "${flavour}";
        };
      };
      gtk3.extraCss = ''
        decoration, window, window.background, window.titlebar, * {
          border-radius: 0px;
        }
      ''; # Fixes bugged context menus
    };
    home.file.".background-image".source = wallpaper;
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "${wallpaper}";
        picture-uri-dark = "${wallpaper}";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "${wallpaper}";
      };
    };
    xdg.dataFile."konsole/Catppuccin.colorscheme".source =
      pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "konsole";
        rev = "7d86b8a1e56e58f6b5649cdaac543a573ac194ca";
        hash = "sha256-EwSJMTxnaj2UlNJm1t6znnatfzgm1awIQQUF3VPfCTM=";
      }
      + /Catppuccin-${Flavour}.colorscheme;
    xdg.configFile = {
      # Libadwaita theme
      # "gtk-4.0/gtk.css".source = ./gtk.css;
      "gtk-4.0" = {
        source = config.gtk.theme.package + /share/themes/Catppuccin-${Flavour}-Standard-${Accent}-Dark/gtk-4.0;
        recursive = true;
      };
      "qt5ct" = {
        source = ./qt5ct;
        recursive = true;
      };
      "waybar/style.css".source = ./waybar/style.css;
    };
    xsession.windowManager.i3.config.colors = let
      pink = "#f28fad";
      black = "#1e1d2f";
      text = "#d9e0ee";
      blue = "#96cdfb";
    in rec {
      focused = {
        border = pink;
        background = black;
        text = text;
        indicator = pink;
        childBorder = pink;
      };
      focusedInactive =
        focused
        // {
          border = black;
          childBorder = black;
          indicator = black;
        };
      unfocused = focusedInactive // {border = black;};
      urgent =
        focused
        // {
          border = blue;
          childBorder = blue;
          indicator = blue;
        };
    };
    wayland.windowManager.hyprland.settings.general = {
      "col.active_border" = "0xfff28fad";
      "col.inactive_border" = "0xff1e1d2f";
    };
    services = {
      dunst.settings = let
        urgency_default = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
      in {
        global.frame_color = "#89b4fa";
        urgency_low = urgency_default;
        urgency_normal = urgency_default;
        urgency_critical =
          urgency_default
          // {
            frame_color = "#fab387";
          };
      };
    };
    programs = {
      # zellij.settings.theme = "catppuccin-${flavour}";
      kitty.theme = "Catppuccin-Macchiato";
      starship = {
        settings =
          {
            palette = "catppuccin_${flavour}";
          }
          // builtins.fromTOML (builtins.readFile
            (pkgs.fetchFromGitHub
              {
                owner = "catppuccin";
                repo = "starship";
                rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc";
                hash = "sha256-soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
              }
              + /palettes/${flavour}.toml));
      };
      foot.settings.colors = {
        # Macchiato theme
        foreground = "cad3f5"; # Text
        background = "24273a"; # Base
        regular0 = "494d64"; # Surface 1
        regular1 = "ed8796"; # red
        regular2 = "a6da95"; # green
        regular3 = "eed49f"; # yellow
        regular4 = "8aadf4"; # blue
        regular5 = "f5bde6"; # pink
        regular6 = "8bd5ca"; # teal
        regular7 = "b8c0e0"; # Subtext 1
        bright0 = "5b6078"; # Surface 2
        bright1 = "ed8796"; # red
        bright2 = "a6da95"; # green
        bright3 = "eed49f"; # yellow
        bright4 = "8aadf4"; # blue
        bright5 = "f5bde6"; # pink
        bright6 = "8bd5ca"; # teal
        bright7 = "a5adcb"; # Subtext 0
      };
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
      spicetify.theme = pkgs.spicePkgs.themes.catppuccin-macchiato;
      helix.settings.theme = "catppuccin_${flavour}";
      gitui.theme =
        builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "gitui";
            rev = "ff1e802cfff3d5ff41b0d829a3df1da8087b1265";
            hash = "sha256-frkGtsk/VuS6MYUf7S2hqNHhTaV6S0Mv2UuttCgvimk=";
          }
          + /theme/${flavour}.ron);
      bat = {
        config.theme = "Catppuccin";
        themes = {
          "Catppuccin" = builtins.readFile (pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "bat";
              rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
              hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
            }
            + "/Catppuccin-${flavour}.tmTheme");
        };
      };
    };
  };
}
