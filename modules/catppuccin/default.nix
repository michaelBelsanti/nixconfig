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
        };
        colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

        qt = {
          # style.catppuccin.enable = (config.qt.platformTheme.name == "kvantum");
          style.name = lib.mkDefault "kvantum";
          platformTheme.name = lib.mkDefault "kvantum";
          # https://github.com/NixOS/nixpkgs/issues/355602#issuecomment-2495539792 - i hate theming kde apps
          kde.settings.kdeglobals.UI.ColorScheme = "*";
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
              overview.backdrop-color = palette.base.hex;
              layout.focus-ring.active.color = palette.${accent}.hex;
              layout.focus-ring.urgent.color = if accent == "red" then palette.blue.hex else palette.red.hex;
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
      };
  };
}
