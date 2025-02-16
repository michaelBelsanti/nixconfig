# Packages to inherit from an input
{
  delib,
  inputs,
  lib,
  ...
}:
let
  infuse = (import inputs.infuse.outPath { inherit lib; }).v1.infuse;
  inherits = _: super: {
    inherit (inputs.nix-alien.packages.${super.system}) nix-alien;
  };
  overlay =
    _self: super:
    infuse super {
      proton-ge-bin.__output.buildCommand.__assign = ''
        runHook preBuild

        # Make it impossible to add to an environment. You should use the appropriate NixOS option.
        # Also leave some breadcrumbs in the file.
        echo "proton-ge-bin should not be installed into environments. Please use programs.steam.extraCompatPackages instead." > $out

        mkdir $steamcompattool
        ln -s $src/* $steamcompattool
        rm $steamcompattool/compatibilitytool.vdf
        cp $src/compatibilitytool.vdf $steamcompattool

        sed -i -r 's|GE-Proton[0-9]*-[0-9]*|GE-Proton|' $steamcompattool/compatibilitytool.vdf

        runHook postBuild
      '';
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
