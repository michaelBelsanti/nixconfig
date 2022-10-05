{
  description = "Quasigod's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    
    nix-gaming.url = "github:fufexan/nix-gaming";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs @ { self, nixpkgs, nix-gaming, nixos-hardware, home-manager, hyprland, darwin, ... }:
  let
    user = "quasi";
  in
  {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nix-gaming nixos-hardware home-manager user hyprland;
      }
    );
    
    darwinConfigurations = (
      import ./hosts/osx {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin user;
      }
    );
  };
}
