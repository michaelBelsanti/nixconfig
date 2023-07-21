{
  config,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/gaming.nix
    ../../modules/vfio
    ../../modules/desktops/i3
    # ../../modules/desktops/plasma/desktop.nix
  ];

  home-manager.users.${user} = {
    # home.pointerCursor.x11.enable = true;
    xsession.initExtra = ''
      easyeffects --gapplication-service &
      xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4
    '';
  };

  networking = {
    nameservers = ["192.168.1.152"];
    networkmanager.dns = "none";
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall = {
      enable = true;
      allowedUDPPorts = [
        3074 # BO2
        24872 # Yuzu
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
    udev.packages = with pkgs; [qmk-udev-rules];
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.sddm = {
        enable = true;
        theme = "chili"; # installed with package `chili-kde-plasma`
      };
      libinput.mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
    };
    openssh = {
      enable = true;
      ports = [42069];
      settings.PasswordAuthentication = false;
    };
  };

  # Causes librewolf to crash occasionally
  hardware = {
    nvidia.modesetting.enable = true;
    # opengl.extraPackages = with pkgs; [
    # vaapiVdpau
    # libvdpau-va-gl
    # nvidia-vaapi-driver
    # ];
  };

  # BUG
  # Vaapi is currently broken on my system
  environment = {
    systemPackages = with pkgs; [
      (sddm-chili-theme.override {
        themeConfig = {
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          background = ../../../home/modules/themes/catppuccin/background_upscayled.png;
        };
      })
    ];
    sessionVariables = {
      # LIBVA_DRIVER_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
