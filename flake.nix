{
  description = "Quasigod's NixOS config";

  outputs =
    inputs@{ snowfall-lib, ... }:
    let
      user = "quasi";
      flakePath = "/home/${user}/.flake"; # Used for commands and aliases
    in
    snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall.namespace = "custom";
      channels-config.allowUnfree = true;

      homes.users."quasi@nyx".specialArgs = {
        inherit flakePath;
      };

      homes.modules = with inputs; [
        spicetify.homeManagerModule
        plasma-manager.homeManagerModules.plasma-manager
        inputs.ironbar.homeManagerModules.default
        nix-colors.homeManagerModules.default
        walker.homeManagerModules.default
        hyprlock.homeManagerModules.default
      ];

      systems.modules.nixos = with inputs; [
        nyx.nixosModules.default
        ssbm.nixosModule
        flake-programs-sqlite.nixosModules.programs-sqlite
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {
            inherit inputs user flakePath;
          };
        }
      ];

      systems.hosts = {
        hades = {
          modules = with inputs; [
            nix-gaming.nixosModules.pipewireLowLatency
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-pc-ssd
          ];

          specialArgs = {
            inherit user flakePath;
          };
        };

        zagreus = {
          modules = with inputs; [ nixos-hardware.nixosModules.framework-12th-gen-intel ];

          specialArgs = {
            inherit user flakePath;
          };
        };
      };

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };

  inputs = {
    nixpkgs-slippi-fix.url = "github:michaelBelsanti/nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

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

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
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

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot
    };
  };
  nixConfig = {
    extra-substituters = [
      "https://quasigod.cachix.org"
      "https://helix.cachix.org"
      "https://hyprland.cachix.org"
      "https://devenv.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://nyx.chaotic.cx/"
      "https://jakestanger.cachix.org"
    ];
    extra-trusted-public-keys = [
      "quasigod.cachix.org-1:z+auA/0uS8vy6DDtUZhRQagZvVdl5WYnE/7lveoM3Do="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "jakestanger.cachix.org-1:VWJE7AWNe5/KOEvCQRxoE8UsI2Xs2nHULJ7TEjYm7mM="
    ];
  };
}
