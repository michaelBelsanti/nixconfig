{
  styx,
  config,
  inputs,
  ...
}:
{
  hostConfig.zagreus = {
    primaryDisplay = config.hostConfig.zagreus.displays.eDP-1;
    displays = {
      eDP-1 = {
        refresh = 60.0;
        width = 2256;
        height = 1504;
        scaling = 1.50;
      };
    };
  };

  den.hosts.x86_64-linux.zagreus = { inherit (config.hostConfig.zagreus) displays primaryDisplay; };
  den.aspects.zagreus = {
    includes = with styx; [
      laptop
      hax
    ];

    nixos =
      { pkgs, ... }:
      {
        facter.reportPath = ./_facter.json;
        imports = [ inputs.nixos-hardware.nixosModules.framework-13-7040-amd ];
        hardware.framework.enableKmod = false;
        hardware.amdgpu.opencl.enable = true;

        boot = {
          # kernelPackages =
          #   inputs.chaotic.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages_cachyos;
          kernelParams = [ "acpi_backlight=native" ];
          plymouth.enable = true;
          binfmt.emulatedSystems = [ "aarch64-linux" ];
        };

        networking.hostName = "zagreus";

        environment.sessionVariables.COSMIC_DISABLE_DIRECT_SCANOUT = 1; # TODO fix crashes

        services = {
          fprintd.enable = false; # Enable fingerprint scanner
          fwupd.enable = true; # Enable firmware updates with `fwupdmgr update`
        };
      };
  };
}
