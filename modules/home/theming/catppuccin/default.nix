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
  mkUpper =
    str:
    (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);
  inherit (config.theming) accent;
  flavor = config.theming.variant;
  catppuccinEnabled = config.theming.enable && (config.theming.theme == "catppuccin");
in
{
  config = lib.mkIf catppuccinEnabled {
    catppuccin = {
      flavor = flavor;
      btop.enable = true;
      fish.enable = true;
      foot.enable = true;
      helix.enable = true;
      kitty.enable = true;
      lazygit.enable = true;
      rio.enable = true;
      starship.enable = true;
      yazi.enable = true;
      zellij.enable = true;
    };
    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    gtk = {
      theme = {
        name = "catppuccin-${flavor}-${accent}-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = flavor;
          accents = [ accent ];
        };
      };
    };
    # qt = {
    #   platformTheme.name = "kvantum";
    #   style = {
    #     name = "kvantum";
    #     catppuccin = {
    #       enable = true;
    #       accent = accent;
    #       flavor = flavor;
    #     };
    #   };
    # };
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
    wayland.windowManager.hyprland.settings.general = {
      "col.active_border" = "0xfff28fad";
      "col.inactive_border" = "0xff1e1d2f";
    };
  };
}
