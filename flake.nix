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

    plasma-manager.url = "github:pjones/plasma-manager";

    hyprland.url = "github:hyprwm/Hyprland";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv/v0.4";
    helix.url = "github:helix-editor/helix";
    spicetify.url = "github:the-argus/spicetify-nix";
  };
  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , nix-gaming
    , home-manager
    , plasma-manager
    , hyprland
    , nixos-hardware
    , darwin
    , devenv
    , helix
    , spicetify
    , ...
    }:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases

      localOverlay = import ./packages/overlays { inherit inputs; };
      inputOverlay = _: super: {
        inherit (helix.packages.${super.system}) helix;
        inherit (devenv.packages.${super.system}) devenv;
        inherit (nix-gaming.packages.${super.system}) wine-tkg;
        inherit (plasma-manager.packages.${super.system}) rc2nix;
        spicePkgs = spicetify.packages.${super.system}.default;
      };

    in
    utils.lib.mkFlake {
      inherit self inputs user flakePath;

      channelsConfig.allowUnfree = true;
      sharedOverlays = [ inputOverlay localOverlay ];

      hostDefaults = { extraArgs = { inherit inputs user flakePath; }; };

      hostDefaults.modules = [
        ./nixos
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit user flakePath; };
          home-manager.users.${user}.imports = [
            ./nixos/home.nix
            spicetify.homeManagerModule
            hyprland.homeManagerModules.default
            plasma-manager.homeManagerModules.plasma-manager
          ];
        }
      ];

      hosts = {
        nix-desktop.modules = [
          ./nixos/desktop
          ./packages/nixos/desktop.nix
          nix-gaming.nixosModules.pipewireLowLatency
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
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
