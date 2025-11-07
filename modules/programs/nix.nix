{ inputs, ... }:
{
  unify = {
    modules.workstation.home =
      { pkgs, ... }:
      {
        home.packages = [ inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.default ];
      };

    home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Nix
          deadnix
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
