{
  delib,
  inputs,
  pkgs,
  ...
}:
let
  flavor = "macchiato";
  accent = "lavender";
  wallpaper = ./background_upscaled.png;
in
delib.rice {
  name = "catppuccin";
  inherits = ["base"];

  nixos = {
    imports = [ inputs.catppuccin.nixosModules.catppuccin ];
    catppuccin = {
      inherit flavor;
      enable = true;
    };
  };

  home = {
    imports = [
      inputs.catppuccin.homeManagerModules.catppuccin
      inputs.nix-colors.homeManagerModule
    ];
    catppuccin = {
      inherit flavor;
      enable = true;
    };
    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme.name = "kvantum";
    };
    gtk = {
      theme = {
        name = "catppuccin-${flavor}-${accent}-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = flavor;
          accents = [ accent ];
        };
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
}
