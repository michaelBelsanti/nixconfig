{
  description = "Quasigod's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    my-nixpkgs.url = "github:quasigod-io/nixpkgs/master";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

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
  outputs = inputs @ { self, nixpkgs, my-nixpkgs, nixos-hardware, home-manager, hyprland, darwin, ... }:
  let
    user = "quasi";
  in
  {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs my-nixpkgs nixos-hardware home-manager user hyprland;
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
