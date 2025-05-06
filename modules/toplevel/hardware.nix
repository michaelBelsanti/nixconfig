{ inputs, ... }:
{
  unify.nixos.imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
}
