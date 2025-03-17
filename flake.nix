{
  description = "Quasigod's NixOS config";

  outputs =
    {
      self,
      denix,
      nixpkgs,
      wrapper-manager,
      ...
    }@inputs:
    let
      paths = [
        ./hosts
        ./modules
        ./rices
      ];
      mkConfigurations =
        isHomeManager:
        let
          homeManagerUser = "quasi";
        in
        denix.lib.configurations {
          inherit isHomeManager homeManagerUser paths;
          homeManagerNixpkgs = nixpkgs;

          specialArgs = {
            inherit
              self
              inputs
              isHomeManager
              homeManagerUser
              wrapper-manager
              ;
          };
        };
    in
    {
      nixosConfigurations = mkConfigurations false;
      homeConfigurations = mkConfigurations true;
    }
    // {
      denixModules = denix.lib.umport { inherit paths; };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-master.url = "github:nixos/nixpkgs/master";
    mypkgs = {
      url = "git+https://codeberg.org/quasigod/nur.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    infuse = {
      url = "git+https://codeberg.org/amjoseph/infuse.nix.git";
      flake = false;
    };

    sops-nix.url = "github:Mic92/sops-nix";

    # nilla-cli = {
    #   url = "github:nilla-nix/cli";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  nixConfig = {
    extra-substituters = [
      "https://quasigod.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://jakestanger.cachix.org"
      "https://cosmic.cachix.org/"
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org/"
      "https://cache.lix.systems"
    ];
    extra-trusted-public-keys = [
      "quasigod.cachix.org-1:z+auA/0uS8vy6DDtUZhRQagZvVdl5WYnE/7lveoM3Do="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "jakestanger.cachix.org-1:VWJE7AWNe5/KOEvCQRxoE8UsI2Xs2nHULJ7TEjYm7mM="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };
}
