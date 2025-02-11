{
  delib,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
delib.rice {
  name = "base";
  inheritanceOnly = true;

  nixos = {
    fonts = {
      packages = with pkgs; [
        jetbrains-mono
        montserrat
        libertine
        inter
        openmoji-color
        nerd-fonts.symbols-only
      ];
      enableDefaultPackages = true;
      fontDir.enable = true;
      fontconfig.defaultFonts = {
        sansSerif = [ "Inter" ];
        monospace = [ "JetBrains Mono" ];
      };
    };
  };

  home = {
    home.pointerCursor = {
      package = pkgs.posy-cursors;
      name = "Posy_Cursor";
      gtk.enable = true;
    };
  };

}
