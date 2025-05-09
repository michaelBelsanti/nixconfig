{ inputs, ... }:
{
  unify.modules.workstation = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = {
          enable = true;
          fonts = {
            sansSerif = {
              package = pkgs.atkinson-hyperlegible-next;
              name = "Atkinson Hyperlegible Next";
            };
            monospace = {
              package = pkgs.jetbrains-mono;
              name = "JetBrains Mono";
            };
            emoji = {
              package = pkgs.openmoji-color;
              name = "OpenMoji";
            };
          };
        };
        fonts = {
          enableDefaultPackages = true;
          packages = with pkgs; [
            montserrat
            libertine
            inter
            nerd-fonts.symbols-only
          ];
        };
      };

    home =
      { pkgs, ... }:
      {
        home.pointerCursor = {
          package = pkgs.posy-cursors;
          name = "Posy_Cursor";
          gtk.enable = true;
        };
      };
  };
}
