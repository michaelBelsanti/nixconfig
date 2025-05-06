{
  unify.modules.workstation = {
    nixos =
      { pkgs, ... }:
      {
        fonts = {
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
      };

    home =
      { pkgs, ... }:
      {
        home = {
          pointerCursor = {
            package = pkgs.posy-cursors;
            name = "Posy_Cursor";
            gtk.enable = true;
          };
        };
      };
  };
}
