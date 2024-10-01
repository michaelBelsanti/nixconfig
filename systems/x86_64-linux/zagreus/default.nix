{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware.nix ];

  # Custom options
  gaming.enable = true;
  desktop = {
    cosmic.enable = true;
  };

  networking.hostName = "zagreus"; # Define your hostname.

  hardware.framework.enableKmod = false;

  boot = {
    kernelParams = [ "acpi_backlight=native" ];
    kernelPackages = pkgs.linuxPackages_latest;
    # blacklistedKernelModules = [ "hid_sensor_hub" ];
    # plymouth.enable = true;
    # initrd.systemd.enable = true; # To load gui for decryption
  };

  # Make fingerprint sensor work at boot
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

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
    xserver = {
      displayManager.gdm.enable = true;
    };
    auto-cpufreq.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    fprintd.enable = false; # Enable fingerprint scanner
    fwupd = {
      enable = true; # Enable firmware updates with `fwupdmgr update`
      # extraRemotes = [ "lvfs-testing" ];
    };
  };

  # Framework stuff
  # environment.etc."fwupd/uefi_capsule.conf".text = lib.mkForce ''
  #   [uefi_capsule]
  #   OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
  #   DisableCapsuleUpdateOnDisk=true
  # '';

  system.stateVersion = "22.05";
}
