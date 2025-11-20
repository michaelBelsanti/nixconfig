{ inputs, ... }:
{
  den.aspects.apps._.nix-tools = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Nix
          deadnix
          nix-init
          nix-inspect
          nixos-rebuild-ng
          nix-output-monitor
          nixpkgs-review
          nix-tree
          nix-update
          nurl
          statix
          vulnix
        ];
      };
  };
}
