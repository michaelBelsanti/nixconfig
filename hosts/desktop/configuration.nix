{ lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../packages/hosts/desktop
      ../../modules/vfio
      ../../modules/i3
    ];

  networking = {
    hostName = "nix";
    nameservers = [ "192.168.1.152" ];
  };

  # Can't use 'max' cause shitty nvidia drivers
  boot = {
    kernelParams = [ "nomodeset" ];
    # Setting resolution manually because nvidia
    loader.grub = {
      gfxmodeEfi = "1920x1080";
      gfxpayloadEfi = "keep";
    };
  };

  # Display shiz
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
      setupCommands = "xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4";
      gdm = {
        enable = true;
        wayland = false;
      };
    };
    desktopManager.gnome.enable = true;
    exportConfiguration = true;
    # Needed because it thinks my mouse is a touchpad :|
    libinput.touchpad = {
      accelProfile = "flat";
      middleEmulation = false;
      additionalOptions = ''
        Option "MiddleEmulation" "off"
      '';
    };
  };

  # Causes librewolf to crash occasionally
  hardware.opengl.extraPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
  
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  services.openssh = {
    enable = true;
    ports = [ 42069 ];
    banner = "You better be me. If you're not fuck off.\n";
    passwordAuthentication = false;
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
