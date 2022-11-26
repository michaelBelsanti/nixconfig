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
      trusted-users = [ "root" "quasi" "michaelbelsanti" ];
      trusted-substituters = [
        "https://quasigod.cachix.org"
        "https://devenv.cachix.org"
        "https://helix.cachix.org"
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
