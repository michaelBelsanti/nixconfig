{
  delib,
  lib,
  pkgs,
  inputs,
  host,
  ...
}:
delib.module {
  name = "boot";
  options.boot = {
    lanzaboote = delib.boolOption false;
    plymouth = delib.boolOption host.isWorkstation;
  };
  nixos.always =
    { cfg, ... }:
    {
      imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
      boot = {
        initrd.systemd.enable = true;
        plymouth.enable = cfg.plymouth;
        lanzaboote = lib.mkIf cfg.lanzaboote {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
        loader = {
          systemd-boot.enable = lib.mkIf (!cfg.lanzaboote) true;
          efi.canTouchEfiVariables = true;
          timeout = 3;
        };
        kernel.sysctl = {
          "transparent_hugepage" = "always";
          "vm.nr_hugepages_defrag" = 0;
          "ipcs_shm" = 1;
          "default_hugepagez" = "1G";
          "hugepagesz" = "1G";
          "vm.swappiness" = 1;
          "vm.compact_memory" = 0;
        };
        supportedFilesystems = [ "ntfs" ]; # Adds NTFS driver
      };
    };
}
