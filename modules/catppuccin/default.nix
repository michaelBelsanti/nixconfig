{ inputs, lib, ... }:
# https://catppuccin.com/palette/
let
  wallpaper = inputs.self + /assets/background_upscaled.png;
in
{
  styx.theming._.catppuccin = flavor: accent: {
    nixos = {
      imports = [ inputs.catppuccin.nixosModules.default ];
      catppuccin = {
        enable = true;
        inherit flavor accent;
      };
    };

    homeManager =
      { config, pkgs, ... }:
      {
        imports = [
          inputs.catppuccin.homeModules.catppuccin
          inputs.nix-colors.homeManagerModule
        ];
        catppuccin = {
          enable = true;
          inherit flavor accent;
          wezterm.apply = true;
          kvantum.enable = false;
          qt5ct.enable = true;
        };
        colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

        qt = {
          platformTheme.name = "qtct";
          style.package = pkgs.darkly;
          kde.settings.kdeglobals.UiSettings.ColorScheme = "catppuccin-mocha-mauve";
          kde.settings.kdeglobals.UiSettings.IconTheme = "papirus-dark";
          qt5ctSettings.Appearance.style = "Darkly";
          qt6ctSettings.Appearance.style = "Darkly";
        };
        gtk.gtk3.theme = {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
        };

        programs = lib.optionalAttrs (config.programs ? niri) {
          niri.settings =
            let
              palette =
                (builtins.fromJSON (builtins.readFile (config.catppuccin.sources.palette + /palette.json)))
                .${flavor}.colors;
            in
            {
              overview.backdrop-color = palette.crust.hex;
              layout = {
                background-color = palette.crust.hex;
                focus-ring.active.color = palette.${accent}.hex;
                focus-ring.urgent.color = if accent == "red" then palette.blue.hex else palette.red.hex;
                tab-indicator.active.color = if accent == "peach" then palette.blue.hex else palette.peach.hex;
              };
            };
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
      };
  };
}
