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
    
    devenv.url = "github:cachix/devenv";
    helix.url = "github:helix-editor/helix";

  };
  outputs = inputs @ { self, nixpkgs, nix-gaming, nixos-hardware, home-manager, hyprland, darwin, devenv, helix, ... }:
    let
      system = "x86_64-linux";
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases

      localOverlays = import ./packages/overlays.nix;
      inputOverlays = [
        (final: prev: {
          inherit (helix.packages.${system}) helix; 
          inherit (devenv.packages.${system}) devenv;
          inherit (nix-gaming.packages.${pkgs.system}) wine-tkg;
        })
      ];
      pkgsConfig = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = inputOverlays ++ [ localOverlays ];
      };
      pkgs = pkgsConfig;
    in
    {
      nixosConfigurations =
        import ./nixos {
          inherit (nixpkgs) lib;
          inherit pkgs system user flakePath inputs home-manager devenv;
        };

      darwinConfigurations =
        import ./osx {
          inherit (nixpkgs) lib;
          inherit system user inputs home-manager darwin devenv;
        };

      devShells."x86_64-linux".rust = import ./shells/rust.nix { inherit pkgs; };
    };
}
