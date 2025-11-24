{
  styx,
  lib,
  inputs,
  ...
}:
{
  styx = {
    boot = {
      nixos.boot.loader = {
        systemd-boot.enable = lib.mkDefault true; # needs to be overridden for secure boot
        efi.canTouchEfiVariables = true;
        timeout = 3;
      };

      provides.secure = {
        includes = [ styx.boot ];
        nixos = {
          imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
          boot = {
            loader.systemd-boot.enable = false;
            lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          };
        };
      };

      provides.graphical.nixos.boot = {
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
  };
}
