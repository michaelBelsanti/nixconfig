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
        plasma-manager.homeManagerModules.plasma-manager
        nix-colors.homeManagerModules.default
        catppuccin-nix.homeManagerModules.catppuccin
      ];

      systems.modules.nixos = with inputs; [
        lix-module.nixosModules.default
        flake-programs-sqlite.nixosModules.programs-sqlite
        catppuccin-nix.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        nixos-cosmic.nixosModules.default
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
            chaotic.nixosModules.default
          ];

          specialArgs = {
            inherit user flakePath;
          };
        };

        zagreus = {
          modules = with inputs; [
            nixos-hardware.nixosModules.framework-13-7040-amd
            lanzaboote.nixosModules.lanzaboote
          ];

          specialArgs = {
            inherit user flakePath;
          };
        };
      };

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nix-colors.url = "github:misterio77/nix-colors";
    catppuccin-nix.url = "github:catppuccin/nix";

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
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

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    infuse = {
      url = "git+https://codeberg.org/amjoseph/infuse.nix.git";
      flake = false;
    };
  };
  nixConfig = {
    extra-substituters = [
      "https://quasigod.cachix.org"
      "https://helix.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://jakestanger.cachix.org"
      "https://cosmic.cachix.org/"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "quasigod.cachix.org-1:z+auA/0uS8vy6DDtUZhRQagZvVdl5WYnE/7lveoM3Do="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "jakestanger.cachix.org-1:VWJE7AWNe5/KOEvCQRxoE8UsI2Xs2nHULJ7TEjYm7mM="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
