# Packages to inherit from an input
{
  delib,
  inputs,
  lib,
  ...
}:
let
  inherit ((import inputs.infuse.outPath { inherit lib; }).v1) infuse;
  inherits = _: super: {
    inherit (inputs.nix-alien.packages.${super.system}) nix-alien;
  };
  overlay =
    _self: super:
    infuse super {

    };
in
delib.module {
  name = "overlay";
  home.always.nixpkgs.overlays = [
    overlay
    inherits
  ];
  nixos.always.nixpkgs.overlays = [
    overlay
    inherits
  ];
}
