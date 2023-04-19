{
  description = "Quasigod's NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    mypkgs.url = "github:michaelBelsanti/nur-packages";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-gaming.url = "github:fufexan/nix-gaming";

    plasma-manager.url = "github:pjones/plasma-manager";
    hyprland.url = "github:hyprwm/Hyprland";

    helix.url = "github:helix-editor/helix";
    devenv.url = "github:cachix/devenv/v0.4";
    spicetify.url = "github:the-argus/spicetify-nix";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };
  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , home-manager
    , mypkgs
    , nix-gaming
    , nixos-hardware
    , plasma-manager
    , hyprland
    , helix
    , devenv
    , spicetify
    , nix-alien
    , ...
    }:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases

      localOverlay = import ./packages/overlay.nix { inherit inputs; };
      inputOverlay = _: super: {
        inherit (helix.packages.${super.system}) helix;
        inherit (devenv.packages.${super.system}) devenv;
        inherit (nix-gaming.packages.${super.system}) wine-tkg;
        inherit (plasma-manager.packages.${super.system}) rc2nix;
        inherit (nix-alien.packages.${super.system}) nix-alien;
        spicePkgs = spicetify.packages.${super.system}.default;
      };
    in
    utils.lib.mkFlake {
      inherit self inputs user flakePath;

      channelsConfig.allowUnfree = true;
      sharedOverlays = [ inputOverlay localOverlay mypkgs.overlays.default ];
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
          ./packages/desktop.nix
          nix-gaming.nixosModules.pipewireLowLatency
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
        ];

        nix-laptop.modules = [
          ./nixos/laptop
          ./packages/laptop.nix
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];

        home = {
          output = "homeConfigurations";
          builder = home-manager.lib.homeManagerConfiguration;
          modules = [ ./nixos/home.nix ];
          extraArgs = { inherit inputs user flakePath; };
        };
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
          # devShells = import ./shells/default.nix { inherit pkgs inputs; };
          formatter = pkgs.nixpkgs-fmt;
        };
    };
}
