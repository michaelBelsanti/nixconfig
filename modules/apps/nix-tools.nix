{ inputs, ... }:
{
  den.aspects.apps._.nix-tools = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Nix
          deadnix
          lixPackageSets.latest.nixpkgs-review
          lixPackageSets.latest.nix-update
          nix-init
          nix-inspect
          nixos-rebuild-ng
          nix-output-monitor
          nix-tree
          nurl
          statix
          vulnix
        ];
      };
  };
}
