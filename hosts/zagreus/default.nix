{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.host {
  name = "zagreus";
  rice = "catppuccin";
  type = "laptop";

  displays = {
    eDP-1 = {
      refreshRate = 60;
      width = 2256;
      height = 1504;
      scaling = 1.75;
    };
  };

  shared.myconfig.services.syncthing.devices.zagreus.id =
    "V3CJAAW-V5ZRINB-SIDYUZH-L6CRFTW-ZOOHA3W-KYMW5ZU-Q4IUMLS-47QSTQQ";

  myconfig = {
    desktops.cosmic.enable = true;
    gaming.enable = true;
    networking.tailscale.remote = true;
    boot.lanzaboote = true;
  };

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "22.05";

  nixos = {
    system.stateVersion = "22.05";
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
      libinput = {
        mouse = {
          accelProfile = "flat";
          middleEmulation = false;
          additionalOptions = ''
            Option "MiddleEmulation" "off"
          '';
        };
        touchpad = {
          accelProfile = "adaptive";
        };
      };
      fprintd.enable = false; # Enable fingerprint scanner
      fwupd = {
        enable = true; # Enable firmware updates with `fwupdmgr update`
        # extraRemotes = [ "lvfs-testing" ];
      };
    };
  };
}
