{ pins }:
{
  config.inputs = {
    unify.src = pins.unify;
    nixpkgs = {
      src = pins.nixpkgs;
      loader = "nixpkgs";
      settings.configuration = {
        allowUnfree = true;
      };
    };
    mypkgs.src = pins.mypkgs;
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
    lix.src = pins.lix;
    lix-module = {
      src = pins.lix-module;
      loader = "raw";
    };
    lanzaboote.src = pins.lanzaboote;
    infuse.src = pins.infuse;
    sops-nix.src = pins.sops-nix;
    nilla-cli.src = pins.nilla-cli;
    nixos.src = pins.nixos;
  };
}
