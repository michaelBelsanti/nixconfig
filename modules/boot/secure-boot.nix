{ inputs, ... }:
{
  unify.modules.secure-boot.nixos = {
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
    boot = {
      loader.systemd-boot.enable = false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
  };
}
