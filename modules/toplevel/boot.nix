{ lib, inputs, ... }:
{
  unify = {
    modules = {
      secure-boot.nixos = {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
        boot = {
          systemd-boot.enable = false;
          lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
        };
      };
      plymouth.nixos.boot = {
        plymouth.enable = true;
        consoleLogLevel = 3;
        initrd.verbose = false;
        initrd.systemd.enable = true;
        kernelParams = [
          "quiet"
          "splash"
          "intremap=on"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];
      };
    };
    nixos.boot = {
      initrd.systemd.enable = true;
      loader = {
        systemd-boot.enable = lib.mkDefault true;
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
