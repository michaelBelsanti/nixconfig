{
  pkgs,
  mylib,
  lib,
  config,
  host,
  ...
}:
let
  cfg = config.themes;
in
{
  options.themes.wallpaper = mylib.mkOption lib.types.path null;
  config = lib.mkIf (host.is "workstation") {
    nixos.fonts = {
      packages = with pkgs; [
        jetbrains-mono
        montserrat
        libertine
        inter
        openmoji-color
        nerd-fonts.symbols-only
        atkinson-hyperlegible-next
      ];
      enableDefaultPackages = true;
      fontDir.enable = true;
      fontconfig.defaultFonts = {
        sansSerif = [ "Atkinson Hyperlegible Next" ];
        monospace = [ "JetBrains Mono" ];
      };
    };

    home.home = {
      home.file.".background-image".source = lib.mkIf (!builtins.isNull cfg.wallpaper);
      pointerCursor = {
        package = pkgs.posy-cursors;
        name = "Posy_Cursor";
        gtk.enable = true;
      };
    };
  };
}
