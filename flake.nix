{
  description = "Quasigod's NixOS config";
 inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
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

    devenv.url = "github:cachix/devenv/v0.4";
    # helix.url = "github:helix-editor/helix";
    spicetify-nix.url = "github:the-argus/spicetify-nix";

  };
  outputs = inputs @ { self, nixpkgs, utils, nix-gaming, home-manager, hyprland, darwin, devenv, helix, ... }:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases

      localOverlays = import ./packages/overlays {inherit inputs;};
      inputOverlays = _: super: {
        inherit (hyprland.packages.${super.system}) hyprland;
        inherit (helix.packages.${super.system}) helix;
        inherit (devenv.packages.${super.system}) devenv;
        inherit (nix-gaming.packages.${super.system}) wine-tkg;
      };

    in utils.lib.mkFlake {
      inherit self inputs user flakePath;

      channelsConfig.allowUnfree = true;
      sharedOverlays = [ inputOverlays localOverlays ];

      hostDefaults = {
        extraArgs = { inherit inputs user flakePath; };
      };

      hostDefaults.modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user flakePath; };
          home-manager.users.${user}.imports = [
            ./nixos/home.nix
          ];
        }
      ];

      hosts = {
        nix-desktop.modules = [
          ./nixos/desktop/configuration.nix
          ./packages/nixos/desktop

          inputs.hyprland.nixosModules.default
          inputs.nix-gaming.nixosModules.pipewireLowLatency
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd

          home-manager.nixosModules.home-manager
          {
            home-manager.users.${user}.imports = [
              ./nixos/desktop/home.nix
              inputs.spicetify-nix.homeManagerModule
            ];
          }
        ];

        nix-laptop.modules = [
          ./nixos/laptop/configuration.nix
          ./packages/nixos/laptop

          inputs.hyprland.nixosModules.default
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
          
          home-manager.nixosModules.home-manager
          {
            home-manager.users.${user}.imports = [
              ./nixos/desktop/home.nix
              inputs.spicetify-nix.homeManagerModule
            ];
          }
        ];
      };
  };
}
