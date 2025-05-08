{ inputs, config, ... }:
{
  unify.hosts.zagreus = {
    tags = [
      "laptop"
      "workstation"
      "hacking"
      "remote"
      "gaming"
      "virtualisation"
      "plymouth"
      "secure-boot"
    ];

    primaryDisplay = config.unify.hosts.zagreus.displays.eDP-1;
    displays = {
      eDP-1 = {
        refreshRate = 60;
        width = 2256;
        height = 1504;
        scaling = 1.50;
      };
    };

    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-hardware.nixosModules.framework-13-7040-amd ];

        facter.reportPath = ./facter.json;
        hardware.framework.enableKmod = false;
        hardware.amdgpu.opencl.enable = true;

        boot.kernelPackages = inputs.chaotic.legacyPackages.${pkgs.system}.linuxPackages_cachyos;

        networking.hostName = "zagreus"; # Define your hostname.

        boot = {
          kernelParams = [ "acpi_backlight=native" ];
          # initrd.kernelModules = [ "amdgpu" ];
          plymouth.enable = true;
        };

        environment.sessionVariables.COSMIC_DISABLE_DIRECT_SCANOUT = 1; # fix crashes

        services = {
          fprintd.enable = false; # Enable fingerprint scanner
          fwupd = {
            enable = true; # Enable firmware updates with `fwupdmgr update`
            # extraRemotes = [ "lvfs-testing" ];
          };
        };
      };
  };
}
