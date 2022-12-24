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

    hyprland.url = "github:hyprwm/Hyprland";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv/v0.4";
    helix.url = "github:helix-editor/helix";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };
  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , nix-gaming
    , home-manager
    , hyprland
    , darwin
    , devenv
    , helix
    , ...
    }:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases

      localOverlays = import ./packages/overlays { inherit inputs; };
      inputOverlays = _: super: {
        inherit (helix.packages.${super.system}) helix;
        inherit (devenv.packages.${super.system}) devenv;
        inherit (nix-gaming.packages.${super.system}) wine-tkg;
      };

    in
    utils.lib.mkFlake {
      inherit self inputs user flakePath;

      channelsConfig.allowUnfree = true;
      sharedOverlays = [ inputOverlays localOverlays ];

      hostDefaults = { extraArgs = { inherit inputs user flakePath; }; };

      hostDefaults.modules = [
        ./nixos/configuration.nix
        inputs.hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user flakePath; };
          home-manager.users.${user}.imports = [
            ./nixos/home.nix
            inputs.spicetify-nix.homeManagerModule
            inputs.hyprland.homeManagerModules.default
          ];
        }
      ];

      hosts = {
        nix-desktop.modules = [
          ./nixos/desktop
          ./packages/nixos/desktop.nix
          inputs.nix-gaming.nixosModules.pipewireLowLatency
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
        ];

        nix-laptop.modules = [
          ./nixos/laptop
          ./packages/nixos/laptop.nix
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
      outputsBuilder = channels:
        let
          lib = devenv.lib;
          pkgs = channels.nixpkgs;
        in
        {
          devShells.default = lib.mkShell {
            inherit pkgs;
            languages.nix.enable = true;
          };

          formatter = channels.nixpkgs.nixpkgs-fmt;
        };
    };
}
