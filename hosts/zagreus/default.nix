{ inputs, config, ... }:
{
  unify.hosts.nixos.zagreus = {
    modules = with config.unify.modules; [
      laptop
      workstation
      hacking
      gaming
      virtualisation
      plymouth
      secure-boot
      syncthing-client
    ];

    primaryDisplay = config.unify.hosts.nixos.zagreus.displays.eDP-1;
    displays = {
      eDP-1 = {
        refreshRate = 60;
        width = 2256;
        height = 1504;
        scaling = 1.50;
      };
    };

    users.quasi.modules = config.unify.hosts.nixos.zagreus.modules;

    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.nixos-hardware.nixosModules.framework-13-7040-amd ];

        facter.reportPath = ./facter.json;
        hardware.framework.enableKmod = false;
        hardware.amdgpu.opencl.enable = true;

        boot = {
          kernelPackages = inputs.chaotic.legacyPackages.${pkgs.system}.linuxPackages_cachyos; # Define your hostname.
          kernelParams = [ "acpi_backlight=native" ];
          plymouth.enable = true;
          binfmt.emulatedSystems = [ "aarch64-linux" ];
        };

        networking.hostName = "zagreus";

        environment.sessionVariables.COSMIC_DISABLE_DIRECT_SCANOUT = 1; # fix crashes

        services = {
          fprintd.enable = false; # Enable fingerprint scanner
          fwupd.enable = true; # Enable firmware updates with `fwupdmgr update`
        };
      };
  };
}
