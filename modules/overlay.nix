# Packages to inherit from an input
{
  inputs,
  lib,
  mylib,
  ...
}:
let
  inherit ((import inputs.infuse.outPath { inherit lib; }).v1) infuse;
  overlay =
    _self: super:
    infuse super {
    };
in
{
  options.overlay.enable = mylib.mkBool false;
  config.nixos.nixpkgs.overlays = lib.mkIf overlay.enable [ overlay ];
}
