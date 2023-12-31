{
  description = "Quasigod's NixOS config";
  outputs = inputs @ {parts, ...}: let
    user = "quasi";
    flakePath = "/home/${user}/.flake"; # Used for commands and aliases
    overlay = import ./overlay.nix inputs;
  in
    parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./nixos/profiles
        ./home/profiles
        {config._module.args = {inherit user flakePath;};}
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        system,
        pkgs,
        ...
      }: {
        devShells = import ./shells pkgs;
        formatter = pkgs.alejandra;
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
          overlays = [
            overlay
            inputs.mypkgs.overlays.default
            inputs.hypr-contrib.overlays.default
            inputs.chaotic.overlays.default
          ];
        };
      };
    };
  inputs = {
    nixpkgs-slippi-fix.url = "github:michaelBelsanti/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    mypkgs = {
      url = "github:michaelBelsanti/nur-packages/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ssbm = {
      url = "github:michaelBelsanti/ssbm-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv/v0.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-index-db = {
    #   url = "github:Mic92/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  nixConfig = {
    extra-substituters = [
      "https://quasigod.cachix.org"
      "https://helix.cachix.org"
      "https://hyprland.cachix.org"
      "https://devenv.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://nyx.chaotic.cx/"
    ];
    extra-trusted-public-keys = [
      "quasigod.cachix.org-1:z+auA/0uS8vy6DDtUZhRQagZvVdl5WYnE/7lveoM3Do="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };
}
