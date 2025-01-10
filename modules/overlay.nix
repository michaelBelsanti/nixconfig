# Packages to inherit from an input
{ delib, inputs, ... }:
let
  overlay = _self: super: {
    inherit (inputs.plasma-manager.packages.${super.system}) rc2nix;
    inherit (inputs.nix-alien.packages.${super.system}) nix-alien;
    inherit (inputs.hypr-contrib.packages.${super.system}) grimblast;
    inherit (inputs.zen-browser.packages.${super.system}) zen-browser;
    gaming = inputs.nix-gaming.packages.${super.system};
  };
in
delib.module {
  name = "overlay";
  home.always.nixpkgs.overlays = [ overlay ];
  nixos.always.nixpkgs.overlays = [ overlay ];
}
