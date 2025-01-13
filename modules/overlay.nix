# Packages to inherit from an input
{ delib, inputs, ... }:
let
  overlay = _self: super: {
    inherit (inputs.nix-alien.packages.${super.system}) nix-alien;
    inherit (inputs.nixpkgs-master.legacyPackages.${super.system}) television;
  };
in
delib.module {
  name = "overlay";
  home.always.nixpkgs.overlays = [ overlay ];
  nixos.always.nixpkgs.overlays = [ overlay ];
}
