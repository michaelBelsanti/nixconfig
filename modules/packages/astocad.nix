{
  perSystem =
    { pkgs, lib, ... }:
    {
      packages.astocad = pkgs.freecad.overrideAttrs (
        self: super: {
          src = pkgs.fetchFromGitHub {
            owner = "AstoCAD";
            repo = "FreeCAD";
            rev = "214716b2833df45ffb7798a82ae557f870886fc6";
            hash = "sha256-5UZ+W6pbKxbtc9wDfZtx7XuckmsRLzFkqZjznvLTIbM=";
            fetchSubmodules = true;
          };
          patches = lib.lists.dropEnd 3 super.patches;
        }
      );
    };
}
