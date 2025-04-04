let
  pins = import ./npins;
  nilla = import pins.nilla;
in
nilla.create (
  { config }:
  {
    includes = [
      "${pins.nilla-nixos}/modules/nixos.nix"
      "${pins.unify}/module.nix"
    ];
    config =
      let
        inputs = builtins.mapAttrs (name: value: value.result) config.inputs;
      in
      {
        lib.unify = inputs.unify.lib.unify;
        unify.systems.hades = {
          paths = [
            ./hosts
            ./modules
            ./rices
          ];
          systemType = "nixos";
          args = {
            inherit inputs;
            nillaConfig = config;
            wrapper-manager = inputs.wrapper-manager;
          };
        };
        inputs = {
          nixpkgs = {
            src = pins.nixpkgs;
            loader = "nixpkgs";
          };
          # nixpkgs-master.src = pins.nixpkgs-master;
          mypkgs.src = pins.mypkgs;
          unify.src = pins.unify;
          denix.src = pins.denix;
          home-manager.src = pins.home-manager;
          nixos-hardware.src = pins.nixos-hardware;
          nixos-facter-modules.src = pins.nixos-facter-modules;
          chaotic.src = pins.chaotic;
          wrapper-manager.src = pins.wrapper-manager;
          nixpak.src = pins.nixpak;
          nix-colors.src = pins.nix-colors;
          catppuccin.src = pins.catppuccin;
          nix-gaming.src = pins.nix-gaming;
          nixos-cosmic.src = pins.nixos-cosmic;
          zen-browser.src = pins.zen-browser;
          nix-alien.src = pins.nix-alien;
          nix-index-database.src = pins.nix-index-database;
          lix-module.src = pins.lix-module;
          lanzaboote.src = pins.lanzaboote;
          infuse.src = pins.infuse;
          sops-nix.src = pins.sops-nix;
          nilla-cli.src = pins.nilla-cli;
        };
      };
  }
)
