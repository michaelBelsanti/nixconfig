{
  delib,
  inputs,
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
    "SV6C3ZK-SEQTM4Y-JFTX2MZ-KAGFTKK-EOENBIP-34XGXDI-DVMCCXR-XM5TQAW";

  myconfig = {
    desktops.cosmic.enable = true;
    gaming.enable = true;
    networking.tailscale.remote = true;
    boot.lanzaboote = true;
  };

  nixos = {
    imports = [ inputs.nixos-hardware.nixosModules.framework-13-7040-amd ];

    facter.reportPath = ./facter.json;
    hardware.framework.enableKmod = false;
    hardware.amdgpu.opencl.enable = true;

    networking.hostName = "zagreus"; # Define your hostname.

    boot = {
      kernelParams = [ "acpi_backlight=native" ];
      # initrd.kernelModules = [ "amdgpu" ];
      plymouth.enable = true;
    };

    services = {
      btrfs.autoScrub.enable = true;
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
