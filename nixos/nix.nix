{ config, pkgs, inputs, ... }:
{
  # Enable unfree repo
  nixpkgs.config.allowUnfree = true;
  # Enable flakes
  nix = {
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "quasi" ];
      trusted-substituters = [
        "https://quasigod.cachix.org"
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      options = "-d";
    };
  };
}
