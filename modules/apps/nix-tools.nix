{ inputs, ... }:
{
  styx.apps._.nix-tools = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Nix
          deadnix
          nix-init
          nix-inspect
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
