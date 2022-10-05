{ config, pkgs, hyprland, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../packages/hosts/laptop
      ../../modules/hyprland
    ];

  networking.hostName = "nix-fw"; # Define your hostname.

  boot = {
    kernelParams = [ "acpi_backlight=native" ];
    blacklistedKernelModules = [ "hid_sensor_hub" ];
    loader.systemd-boot.consoleMode = "max";
  };


  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    # desktopManager.gnome.enable = true;
    # desktopManager.plasma5.enable = true;
    # displayManager.xserverArgs = [ "-logfile '/var/log/X.log'" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    # displayManager.lightdm = {
    #   enable = true;
    # };
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
  };

  # Graphics drivers
  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      vaapiIntel
    ];
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
  services = {
    tlp.enable = true; # Battery optimization
    power-profiles-daemon.enable = false;
    fprintd.enable = true; # Enable fingerprint scanner 
    fwupd = {
      enable = true; # Enable firmware updates with `fwupdmgr update`
      enableTestRemote = true;
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
