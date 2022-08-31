{
  description = "Quasigod's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # my-nixpkgs.url = "github:quasigod-io/nixpkgs/master";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs @ { self, nixpkgs, my-nixpkgs, nixos-hardware, home-manager, hyprland, ... }:
    let
      user = "quasi";
      protocol = "x";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs my-nixpkgs nixos-hardware home-manager user hyprland protocol;
        }
      );
    };
}
