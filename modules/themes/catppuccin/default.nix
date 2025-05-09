{ inputs, ... }:
let
  wallpaper = ./background_upscaled.png;
  # https://catppuccin.com/palette/
  flavor = "mocha";
  accent = "pink";
in
{
  unify = {
    nixos =
      { pkgs, ... }:
      {
        stylix = {
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
          image = wallpaper;
        };
        imports = [ inputs.catppuccin.nixosModules.default ];
        catppuccin = {
          enable = true;
          inherit flavor accent;
        };
      };

    home =
      { pkgs, ... }:
      {
        imports = [ inputs.catppuccin.homeModules.catppuccin ];
        catppuccin = {
          enable = true;
          inherit flavor accent;
        };
        qt = {
          style.name = "kvantum";
          platformTheme.name = "kvantum";
          # https://github.com/NixOS/nixpkgs/issues/355602#issuecomment-2495539792 - i hate theming kde apps
          kde.settings.kdeglobals.UI.ColorScheme = "*";
        };
        gtk.theme = {
          name = "adw-gtk3";
          package = pkgs.adw-gtk3;
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
