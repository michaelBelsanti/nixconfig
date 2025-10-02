{ inputs, ... }:
{
  unify = {
    modules.workstations.home =
      { pkgs, ... }:
      {
        home.packages = [ inputs.nix-alien.packages.${pkgs.system}.default ];
      };

    home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Nix
          comma
          deadnix
          inputs.nix-alien.packages.${system}.default
          lixPackageSets.latest.nix-direnv
          lixPackageSets.latest.nixpkgs-review
          nh
          nix-init
          nix-inspect
          nixos-rebuild-ng
          nix-output-monitor
          nix-tree
          nix-update
          npins
          nurl
          statix
          vulnix
        ];
      };
  };
}
