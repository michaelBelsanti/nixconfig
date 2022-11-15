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
    
    devenv.url = "github:cachix/devenv/v0.2";

  };
  outputs = inputs @ { self, nixpkgs, nix-gaming, nixos-hardware, home-manager, hyprland, darwin, devenv, ... }:
    let
      system = "x86_64-linux";
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = (
        import ./nixos {
          inherit (nixpkgs) lib;
          inherit system user flakePath inputs home-manager devenv;
        }
      );

      darwinConfigurations = (
        import ./osx {
          inherit (nixpkgs) lib;
          inherit system user inputs home-manager darwin devenv;
        }
      );

      devShells."x86_64-linux".rust = import ./shells/rust.nix { inherit pkgs; };
    };
}
