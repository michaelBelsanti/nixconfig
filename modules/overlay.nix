# Packages to inherit from an input
{
  delib,
  inputs,
  lib,
  ...
}:
let
  inherit ((import inputs.infuse.outPath { inherit lib; }).v1) infuse;
  overlay =
    _self: super:
    infuse super {
    };
in
delib.module {
  name = "overlay";
  options = delib.singleEnableOption false;
  nixos.always.nixpkgs.overlays = [ overlay ];
}
