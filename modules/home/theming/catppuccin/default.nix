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
    catppuccin.flavour = flavour;
    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    home.packages = with pkgs; [ catppuccin-qt5ct ];
    gtk = {
      catppuccin = {
        enable = true;
        cursor.enable = true;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
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
    xdg.configFile."ironbar/style.css" = import ./ironbar.nix { inherit inputs; };
    wayland.windowManager.hyprland.settings.general = {
      "col.active_border" = "0xfff28fad";
      "col.inactive_border" = "0xff1e1d2f";
    };
    programs = {
      fish.catppuccin.enable = true;
      helix.catppuccin.enable = true;
      rio.catppuccin.enable = true;
      lazygit.catppuccin.enable = true;
      starship.catppuccin.enable = true;
      yazi.catppuccin.enable = true;
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
    };
  };
}
