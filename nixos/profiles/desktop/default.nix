{
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
    services.easyeffects.enable = true;
  };

  networking = {
    hostName = "nix-desktop";
    firewall = {
      enable = false;
      allowedUDPPorts = [
        3074 # BO2
        24872 # Yuzu
      ];
    };
  };

  boot.loader.grub = {
    # gfxmodeEfi = "1920x1080";
    # gfxpayloadEfi = "keep";
    theme = pkgs.rosepine-grub-theme;
  };

  # Display shiz
  services = {
    xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.i3}/bin/i3";
    };
    murmur = {
      enable = true;
      bandwidth = 130000;
    };
    pipewire.lowLatency.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager = {
        setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4";
        sddm = {
          enable = true;
          theme = "chili"; # installed with package `chili-kde-plasma`
        };
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
    keyboard.qmk.enable = true;
    nvidia.modesetting.enable = true;
    opengl.extraPackages = with pkgs; [
      nvidia-vaapi-driver
      # vaapiVdpau
      # libvdpau-va-gl
    ];
  };

  virtualisation.podman.enableNvidia = true;

  # BUG
  # Vaapi is currently broken on my system
  environment = {
    systemPackages = with pkgs; [
      (sddm-chili-theme.override {
        themeConfig = {
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          background = pkgs.rosepine-wallpaper;
        };
      })
    ];
    sessionVariables = {
      # NVD_BACKEND = "direct";
      # LIBVA_DRIVER_NAME = "nvidia";
      # MOZ_DISABLE_RDD_SANDBOX = "1";
      # __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  # Nvidia hardware decoding
  programs.firefox.preferences = {
    # "media.ffmpeg.vaapi.enabled" = true;
    # "media.rdd-ffmpeg.enabled" = true;
    # "media.av1.enabled" = false;
    # "gfx.x11-egl.force-enabled" = true;
    # "widget.dmabuf.force-enabled" = true;
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
