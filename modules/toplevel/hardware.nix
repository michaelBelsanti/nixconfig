{ unify, inputs, ... }:
unify.module {
  name = "hardware";
  nixos.always.imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
}
