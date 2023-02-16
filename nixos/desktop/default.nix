{ config, pkgs, user, ... }: {
  imports = [
    ./hardware.nix
    ../../modules/vfio
    # ../../modules/desktop/i3
    ../../modules/desktop/kde/desktop.nix
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
    firewall = {
      enable = true;
      allowedUDPPorts = [
        3074 # BO2
      ];
    };
  };

  boot = {
    # kernelParams = [ "nomodeset" ];
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
    # windowManager.i3.enable = true; # Configured by ../../modules/i3 import
    displayManager = {
      setupCommands =
        "xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4";
      sddm = {
        enable = true;
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
  hardware = {
    opengl.extraPackages = [ pkgs.nvidia-vaapi-driver ];
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
    };
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-kde ];

  services = {
    pipewire.lowLatency.enable = true;
    # miniupnpd = {
    #   enable = true;
    #   upnp = true;
    # };
    openssh = {
      enable = true;
      ports = [ 42069 ];
      banner = ''
        You better be me. If you're not fuck off.
      '';
      settings = {
        PasswordAuthentication = false;
      };
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
