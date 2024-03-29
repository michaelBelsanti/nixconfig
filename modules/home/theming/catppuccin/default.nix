# Imported by home-manager,
# Sets catppuccin theming for any apps that can easily have their theming seperated from the rest of the config
{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  wallpaper = ./background_upscaled.png;
  capitalizeFirstLetter =
    str:
    let
      firstLetter = builtins.substring 0 1 str;
      restOfString = builtins.substring 1 (builtins.stringLength str) str;
    in
    builtins.concatStringsSep "" [
      (lib.strings.toUpper firstLetter)
      restOfString
    ];
  catppuccinEnabled = config.theming.enable && (config.theming.theme == "catppuccin");
  inherit (config.theming) accent;
  Accent = capitalizeFirstLetter accent;
  flavour = config.theming.variant;
  Flavour = capitalizeFirstLetter config.theming.variant;
in
{
  config = lib.mkIf catppuccinEnabled {
    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    home.packages = with pkgs; [ catppuccin-qt5ct ];
    gtk = {
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
      theme = {
        name = "Catppuccin-${Flavour}-Standard-${Accent}-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "${accent}" ];
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
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "konsole";
        rev = "7d86b8a1e56e58f6b5649cdaac543a573ac194ca";
        hash = "sha256-EwSJMTxnaj2UlNJm1t6znnatfzgm1awIQQUF3VPfCTM=";
      }
      + /Catppuccin-${Flavour}.colorscheme;
    xdg.configFile = {
      "swaync/style.css" = {
        text = builtins.readFile (pkgs.fetchurl {
          url = "https://github.com/catppuccin/swaync/releases/download/v0.1.2.1/${flavour}.css";
          hash = "sha256-6X+KSIYcPRQDGm1YV8rk5mq21Gk/pFCugOEoavh3tBw=";
        });
      };
      "ironbar/style.css" = import ./ironbar.nix {inherit inputs;};
    };
    wayland.windowManager.hyprland.settings.general = {
      "col.active_border" = "0xfff28fad";
      "col.inactive_border" = "0xff1e1d2f";
    };
    programs = {
      yazi.theme = builtins.fromTOML (
        builtins.readFile (
          pkgs.fetchFromGitHub {
            owner = "yazi-rs";
            repo = "themes";
            rev = "a0e432e00ad4cf608fea62220e0398e2375c5319";
            hash = "sha256-XzoRcsNtSqv3ojNpKBie/a3eQ4I6/15BTmstaP6vMLg=";
          }
          + /catppuccin-${flavour}/theme.toml
        )
      );
      zellij.settings.theme = "catppuccin-${flavour}";
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
      spicetify = with pkgs.spicePkgs.themes; {
        theme = catppuccin;
        colorScheme = "${flavour}";
      };
      helix.settings.theme = "catppuccin_${flavour}";
    };
  };
}
