{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware.nix ];

  # Custom options
  desktop = {
    wayland.enable = true;
    gnome.enable = true;
  };

  networking.hostName = "zagreus"; # Define your hostname.

  boot = {
    kernelParams = [ "acpi_backlight=native" ];
    blacklistedKernelModules = [ "hid_sensor_hub" ];
    loader.grub.theme = pkgs.framework-grub-theme;
    plymouth.enable = true;
    initrd.systemd.enable = true; # To load gui for decryption
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
      videoDrivers = [ "intel" ];
      displayManager.gdm.enable = true;
    };
    auto-cpufreq.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    fprintd.enable = false; # Enable fingerprint scanner
    fwupd = {
      enable = true; # Enable firmware updates with `fwupdmgr update`
      extraRemotes = [ "lvfs-testing" ];
    };
  };

  # Graphics drivers
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  # Framework stuff
  environment.etc."fwupd/uefi_capsule.conf".text = lib.mkForce ''
    [uefi_capsule]
    OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
    DisableCapsuleUpdateOnDisk=true
  '';

  system.stateVersion = "22.05";
}
