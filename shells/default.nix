{ pkgs, inputs, ... }:
let
  mkShell = inputs.devenv.lib.mkShell;
in
{
  default = mkShell {
    inherit pkgs inputs;
    modules = [
      { languages.nix.enable = true; }
    ];
  };
}
