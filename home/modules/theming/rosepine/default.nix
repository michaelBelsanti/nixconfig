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
      "waybar/style.css".source = ./waybar/style.css;
    };
    xsession.windowManager.i3.config.colors = let
      rose = "#ebbcba";
      black = "#191724";
      text = "#e0def4";
      love = "#eb6f92";
    in rec {
      focused = {
        border = rose;
        background = black;
        text = text;
        indicator = love;
        childBorder = rose;
      };
      focusedInactive =
        focused
        // {
          border = black;
          childBorder = black;
        };
      unfocused = focusedInactive // {border = black;};
      urgent =
        focused
        // {
          border = love;
          childBorder = love;
        };
    };
    wayland.windowManager.hyprland.settings.general = {
      "col.active_border" = "0xff191724";
      "col.inactive_border" = "0xffebbcba";
    };
    services = {
      # TODO mako theme
      dunst.settings = let
        urgency_default = {
          background = "#191724";
          foreground = "#e0def4";
        };
      in {
        global.frame_color = "#ebbcba";
        urgency_low = urgency_default;
        urgency_normal = urgency_default;
        urgency_critical =
          urgency_default
          // {
            frame_color = "#eb6f92";
          };
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
      spicetify = with pkgs.spicePkgs.themes; {
        theme = Ziro;
        # theme = Sleek;
        colorScheme = "rose-pine${variant}"; # For Sleek
        # colorScheme = "RosePine"; # For Sleek
      };
      helix.settings.theme = "rose_pine${variant}";
    };
  };
}
