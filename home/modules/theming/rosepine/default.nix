# Imported by home-manager,
# Sets catppuccin theming for any apps that can easily have their theming seperated from the rest of the config
{
  lib,
  pkgs,
  config,
  ...
}: let
  rosePineEnabled = config.theming.enable && (config.theming.theme == "rosepine");
  variant =
    if (config.theming.variant == "")
    then ""
    else builtins.concatStringsSep "" ["-" config.theming.variant];
in {
  config = lib.mkIf rosePineEnabled {
    home.file.".background-image".source = pkgs.rosepine-wallpaper;
    gtk = {
      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine${variant}";
      };
      theme = {
        name = "rose-pine";
        package = pkgs.rose-pine-gtk-theme;
      };
    };
    xdg.configFile = {
      # Libadwaita theme
      "gtk-4.0" = {
        source = config.gtk.theme.package + /share/themes/rose-pine${variant}/gtk-4.0;
        recursive = true;
      };
      "qt5ct" = {
        source = ./qt5ct;
        recursive = true;
      };
    };
    programs = {
      kitty.theme = "Rosé Pine";
      foot.settings = {
        cursor.color = "191724 e0def4";
        colors = {
          background = "191724";
          foreground = "e0def4";
          regular0 = "26233a";
          regular1 = "eb6f92";
          regular2 = "31748f";
          regular3 = "f6c177";
          regular4 = "9ccfd8";
          regular5 = "c4a7e7";
          regular6 = "ebbcba";
          regular7 = "e0def4";
          bright0 = "6e6a86";
          bright1 = "eb6f92";
          bright2 = "31748f";
          bright3 = "f6c177";
          bright4 = "9ccfd8";
          bright5 = "c4a7e7";
          bright6 = "ebbcba";
          bright7 = "e0def4";
        };
      };
      alacritty.settings = builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub {
          owner = "rose-pine";
          repo = "alacritty";
          rev = "3c3e36eb5225b0eb6f1aa989f9d9e783a5b47a83";
          hash = "sha256-LU8H4e5bzCevaabDgVmbWoiVq7iJ4C1VfQrWGpRwLq0=";
        }
        + /dist/rose-pine${variant}.toml));
      spicetify = {
        theme = pkgs.spicePkgs.themes.Ziro;
        colorScheme = "rose-pine";
      };
      helix.settings.theme = "rose_pine${variant}";
    };
  };
}
