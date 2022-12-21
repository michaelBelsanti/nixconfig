{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/hyprland
  ];

  home-manager.users.${user} = { ... }: {
    imports = [ ../../modules/hyprland/config ];
  };

  networking.hostName = "nix-laptop"; # Define your hostname.

  boot = {
    kernelParams = [ "acpi_backlight=native" ];
    blacklistedKernelModules = [ "hid_sensor_hub" ];
    loader.systemd-boot.consoleMode = "max";
  };

  # Make fingerprint sensor work at boot
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  programs.hyprland.enable = true; # Configured by ../../modules/hyprland import
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    desktopManager.plasma5.enable = false;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    libinput = {
      mouse = {
        accelProfile = "flat";
        middleEmulation = false;
        additionalOptions = ''
          Option "MiddleEmulation" "off"
        '';
      };
      touchpad = { accelProfile = "adaptive"; };
    };
  };

  # Graphics drivers
  environment.variables = { LIBVA_DRIVER_NAME = "iHD"; };
  hardware.opengl = {
    extraPackages = with pkgs;
      [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  ### Services and hardware ###

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      # gtkUsePortal = false;
    };
  };

  # Framework stuff
  environment.etc."fwupd/uefi_capsule.conf".text = lib.mkForce ''
    [uefi_capsule]
    OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
    DisableCapsuleUpdateOnDisk=true
  '';
  services = {
    tlp.enable = true; # Battery optimization
    power-profiles-daemon.enable = false;
    fprintd.enable = true; # Enable fingerprint scanner
    fwupd = {
      enable = true; # Enable firmware updates with `fwupdmgr update`
      enableTestRemote = true;
      extraRemotes = [ "lvfs-testing" ];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
