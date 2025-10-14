{ inputs, lib, ... }:
let
  wallpaper = ./background_upscaled.png;
  # https://catppuccin.com/palette/
  flavor = "mocha";
  accent = "pink";
in
{
  unify.modules.catppuccin = {
    nixos = {
      imports = [ inputs.catppuccin.nixosModules.default ];
      catppuccin = {
        enable = true;
        inherit flavor accent;
      };
    };

    home =
      { config, ... }:
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
          style.name = lib.mkForce "kvantum";
          platformTheme.name = lib.mkForce "kvantum";
          # https://github.com/NixOS/nixpkgs/issues/355602#issuecomment-2495539792 - i hate theming kde apps
          kde.settings.kdeglobals.UI.ColorScheme = "*";
        };
        home.file.".background-image".source = wallpaper;
        xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
        dconf.settings = {
          "org/gnome/desktop/background" = {
            picture-uri = "${wallpaper}";
            picture-uri-dark = "${wallpaper}";
          };
          "org/gnome/desktop/screensaver" = {
            picture-uri = "${wallpaper}";
          };
        };
        programs = lib.optionalAttrs (config.programs ? niri) {
          niri.settings.layout =
            let
              palette = (lib.importJSON "${config.catppuccin.sources.palette}/palette.json").${flavor}.colors;
            in
            {
              focus-ring.active.color = palette.${accent}.hex;
              focus-ring.inactive.color = palette.base.hex;
              background-color = palette.mantle.hex;
            };
        };
      };
  };
}
