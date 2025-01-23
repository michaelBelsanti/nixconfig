{ delib, pkgs, inputs, ... }:
delib.host {
  name = "zagreus";
  rice = "catppuccin";
  type = "laptop";

  displays = [
    {
      name = "eDP-1";
      refreshrate = 60;
      width = 2256;
      height = 1504;
    }
  ];

  myconfig = {
    desktops.cosmic.enable = true;
    gaming.enable = true;
    services.tailscale.remote = true;
  };

  nixos = {
    imports = with inputs; [
      nixos-hardware.nixosModules.framework-13-7040-amd
      lanzaboote.nixosModules.lanzaboote
    ];

    networking.hostName = "zagreus"; # Define your hostname.

    hardware.framework.enableKmod = false;

    boot = {
      kernelParams = [ "acpi_backlight=native" ];
      kernelPackages = pkgs.linuxPackages_latest;
      # blacklistedKernelModules = [ "hid_sensor_hub" ];
      # plymouth.enable = true;
      initrd.systemd.enable = true; # To load gui for decryption
      # Lanzaboote currently replaces the systemd-boot module.
      loader.systemd-boot.enable = false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    # Make fingerprint sensor work at boot
    systemd.services.fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "simple";
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
      xserver = {
        displayManager.gdm.enable = true;
      };
      # auto-cpufreq.enable = true;
      fprintd.enable = false; # Enable fingerprint scanner
      fwupd = {
        enable = true; # Enable firmware updates with `fwupdmgr update`
        # extraRemotes = [ "lvfs-testing" ];
      };
    };
  };
}
