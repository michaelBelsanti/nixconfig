{ config, pkgs, inputs, ... }:
{
  # Enable unfree repo
  nixpkgs.config.allowUnfree = true;
  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      options = "-d";
    };
  };
}
