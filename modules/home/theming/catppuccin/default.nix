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
        cursor.enable = false;
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
      btop.catppuccin.enable = true;
      fish.catppuccin.enable = true;
      foot.catppuccin.enable = true;
      helix.catppuccin.enable = true;
      kitty.catppuccin.enable = true;
      lazygit.catppuccin.enable = true;
      rio.catppuccin.enable = true;
      starship.catppuccin.enable = true;
      yazi.catppuccin.enable = true;
      zellij.catppuccin.enable = true;
      spicetify = with pkgs.spicePkgs.themes; {
        theme = catppuccin;
        colorScheme = "${flavour}";
      };
    };
  };
}
