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

  boot.loader.grub = {
    # gfxmodeEfi = "1920x1080";
    # gfxpayloadEfi = "keep";
    theme = pkgs.minegrub;
  };

  # Display shiz
  services = {
    pipewire.lowLatency.enable = true;
    udev.packages = with pkgs; [ qmk-udev-rules ];
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager.sddm.enable = true;
      libinput.mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
    };
    openssh = {
      enable = true;
      ports = [ 42069 ];
      settings.PasswordAuthentication = false;
    };
  };

  # Causes librewolf to crash occasionally
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
    };
    opengl.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  # Use VA-API
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
