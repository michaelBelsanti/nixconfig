{
  description = "Quasigod's NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nix-gaming.url = "github:fufexan/nix-gaming";

    plasma-manager.url = "github:pjones/plasma-manager";
    hyprland.url = "github:hyprwm/Hyprland";

    helix.url = "github:helix-editor/helix";
    devenv.url = "github:cachix/devenv/v0.4";
    spicetify.url = "github:the-argus/spicetify-nix";
    # darwin = {
    #   url = "github:lnl7/nix-darwin/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , home-manager
    , nix-gaming
    , nixos-hardware
    , plasma-manager
    , hyprland
    , helix
    , devenv
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
      hostDefaults = { 
        extraArgs = { inherit inputs user flakePath; };
      };

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
          pkgs = channels.nixpkgs;
        in
        {
          # DevShells currently broken
          # Feature requires devenv v0.5 to work
          # With versions above v0.4 my system fails to build with this error:
          # error: anonymous function at /nix/store/x070biyjfvlvkf7qpypmfspxzy9a3y3n-source/pkgs/tools/networking/curl/default.nix:1:1 called with unexpected argument 'patchNetrcRegression'
          devShells = import ./shells/default.nix { inherit pkgs inputs; };
          formatter = channels.nixpkgs.nixpkgs-fmt;
        };
    };
}
