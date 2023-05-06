{
  description = "Quasigod's NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    hm = {
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
  outputs = inputs@{flake-parts, ... }:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases
      overlay = import ./overlay.nix inputs;
    in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./nixos/hosts
        ./home/profiles
        {config._module.args = {inherit user flakePath;};}
      ];
      systems = [ "x86_64-linux" ];
      perSystem = { system, ... }: {
        devShells = import ./shells;
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ 
            overlay
            inputs.mypkgs.overlays.default
            inputs.hypr-contrib.overlays.default
          ];
        };
      };
    };
}
