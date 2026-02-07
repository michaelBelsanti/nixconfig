{ styx, ... }:
{
  styx.theming = {
    includes = [ (styx.theming._.catppuccin "mocha" "mauve") ];
    nixos =
      { pkgs, ... }:
      {
        fonts = {
          packages = with pkgs; [
            maple-mono.NF
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
            serif = [ "Liberation Serif" ];
            monospace = [ "Maple Mono NF" ];
            emoji = [ "OpenMoji Color" ];
          };
        };
      };

    homeManager =
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
