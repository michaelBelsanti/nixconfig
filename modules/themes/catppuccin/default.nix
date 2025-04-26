{
  inputs,
  pkgs,
  config,
  lib,
  mylib,
  ...
}:
let
  wallpaper = ./background_upscaled.png;
  cfg = config.themes.catppuccin;
in
{
  options.themes.catppuccin = {
    flavor = mylib.mkOption (lib.types.enum [
      "latte"
      "frappe"
      "macchiato"
      "mocha"
    ]) "mocha";
    accent = mylib.mkOption (lib.types.enum [
      "blue"
      "flamingo"
      "green"
      "lavender"
      "maroon"
      "mauve"
      "peach"
      "pink"
      "red"
      "rosewater"
      "sapphire"
      "sky"
      "teal"
      "yellow"
    ]) "pink";
  };

  config = lib.mkIf cfg.enable {
    themes.wallpaper = ./background.png;
    nixos = {
      imports = [ inputs.catppuccin.nixosModules.catppuccin ];
      catppuccin = {
        enable = true;
        inherit (cfg) flavor accent;
      };
    };

    home = {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.nix-colors.homeManagerModule
      ];
      catppuccin = {
        enable = true;
        inherit (cfg) flavor accent;
      };
      colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
      qt = {
        enable = true;
        style.name = "kvantum";
        platformTheme.name = "kvantum";
      };
      gtk = {
        theme = {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
        };
      };

      home.file.".background-image".source = wallpaper;
      # https://github.com/NixOS/nixpkgs/issues/355602#issuecomment-2495539792 - i hate theming kde apps
      xdg.configFile."kdeglobals" = {
        enable = true;
        text = ''
          [UiSettings]
          ColorScheme=*
        '';
      };
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

    myconfig = {
      programs.television.settings = {
        ui.theme = "catppuccin";
        previewers.file.theme = "Catppuccin Macchiato";
      };
    };
  };
}
