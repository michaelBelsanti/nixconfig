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
    hyprland.url = "github:hyprwm/Hyprland/v0.24.1";
    hypr-contrib.url = "github:hyprwm/contrib";

    helix.url = "github:helix-editor/helix";
    devenv.url = "github:cachix/devenv/v0.4";
    spicetify.url = "github:the-argus/spicetify-nix";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };
  outputs =
    inputs@{self, utils, home-manager, nixos-hardware, ...}:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases
      overlay = import ./packages/overlay.nix inputs;
    in
    utils.lib.mkFlake {
      inherit self inputs user flakePath;

      channelsConfig.allowUnfree = true;
      sharedOverlays = with inputs; [
        overlay
        mypkgs.overlays.default
        hypr-contrib.overlays.default
      ];
      hostDefaults = {
        extraArgs = { inherit inputs user flakePath; };
      };

      hostDefaults.modules = [
        ./nixos
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs user flakePath; };
          home-manager.users.${user}.imports = [
            ./nixos/home.nix
            inputs.spicetify.homeManagerModule
            inputs.plasma-manager.homeManagerModules.plasma-manager
            inputs.hyprland.homeManagerModules.default
          ];
        }
      ];

      hosts = {
        nix-desktop.modules = [
          ./nixos/desktop
          ./packages/desktop.nix
          inputs.nix-gaming.nixosModules.pipewireLowLatency
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
        ];

        nix-laptop.modules = [
          ./nixos/laptop
          ./packages/laptop.nix
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
      outputsBuilder = channels:
        let
          pkgs = channels.nixpkgs;
        in
        {
          devShells = import ./shells/default.nix { inherit pkgs; };
          formatter = pkgs.nixpkgs-fmt;
        };
    };
}
