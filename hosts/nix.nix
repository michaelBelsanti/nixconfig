{ config, pkgs, inputs, ... }:
{
  # Enable unfree repo
  nixpkgs.config.allowUnfree = true;
  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    # interval = "weekly";
    options = "-d";
  };
  nix.settings.auto-optimise-store = true;
}
