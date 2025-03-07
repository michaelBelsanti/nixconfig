{ delib, inputs, ... }:
delib.module {
  name = "hardware";
  nixos.always.imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
}
