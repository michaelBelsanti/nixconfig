# Packages to inherit from an input
{
  unify,
  inputs,
  lib,
  ...
}:
# let
#   inherit ((import inputs.infuse.outPath { inherit lib; }).v1) infuse;
#   overlay =
#     _self: super:
#     infuse super {
#     };
# in
unify.module {
  name = "overlay";
  options = unify.singleEnableOption false;
  # home.always.nixpkgs.overlays = [ overlay ];
  # nixos.always.nixpkgs.overlays = [ overlay ];
}
