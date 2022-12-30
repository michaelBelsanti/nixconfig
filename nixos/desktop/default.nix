{ pkgs, user, ... }: {
  imports = [
    ./hardware.nix
    ../../modules/vfio
    ../../modules/desktop/i3
  ];

  home-manager.users.${user} = {
    # home.pointerCursor.x11.enable = true;
    xsession.initExtra = ''
      easyeffects --gapplication-service &
      xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4
    '';
  };

  networking = {
    nameservers = [ "192.168.1.152" ];
    networkmanager.dns = "none";
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.enable = true;
  };

  boot = {
    kernelParams = [ "nomodeset" ];
    extraModprobeConfig = "options nvidia_drm modeset=1";
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
    windowManager.i3.enable = true; # Configured by ../../modules/i3 import
    # desktopManager.plasma5.enable = true;
    displayManager = {
      setupCommands =
        "xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4";
      gdm = {
        enable = true;
        wayland = false;
      };
    };
    # Needed because it thinks my mouse is a touchpad :|
    libinput = {
      mouse = {
        accelProfile = "flat";
        middleEmulation = false;
        additionalOptions = ''
          Option "MiddleEmulation" "off"
        '';
      };
      touchpad = {
        accelProfile = "flat";
        middleEmulation = false;
        additionalOptions = ''
          Option "MiddleEmulation" "off"
        '';
      };
    };
  };

  # Causes librewolf to crash occasionally
  hardware.opengl.extraPackages = with pkgs; [ nvidia-vaapi-driver ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-kde ];

  services = {
    pipewire.lowLatency.enable = true;
    openssh = {
      enable = true;
      ports = [ 42069 ];
      banner = ''
        You better be me. If you're not fuck off.
      '';
      passwordAuthentication = false;
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
