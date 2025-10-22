{ lib, ... }:
{
  unify = {
    modules.workstation.nixos.boot = {
      kernel.sysctl."vm.swappiness" = 1;
      supportedFilesystems = [ "ntfs" ]; # Adds NTFS driver
    };
    nixos.boot = {
      initrd.systemd.enable = true;
      loader = {
        systemd-boot.enable = lib.mkDefault true; # needs to be overridden for secure boot
        efi.canTouchEfiVariables = true;
        timeout = 3;
      };
      kernel.sysctl = {
        "transparent_hugepage" = "always";
        "vm.nr_hugepages_defrag" = 0;
        "ipcs_shm" = 1;
        "default_hugepagez" = "1G";
        "hugepagesz" = "1G";
        "vm.compact_memory" = 0;
      };
    };
  };
}
