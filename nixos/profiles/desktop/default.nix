{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware.nix
    ../../modules/gaming.nix
    ../../modules/vfio
    # ../../modules/desktops/i3
    ../../modules/desktops/plasma/desktop.nix
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

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.grub = {
    # gfxmodeEfi = "1920x1080";
    # gfxpayloadEfi = "keep";
    theme = pkgs.rosepine-grub-theme;
  };

  # Display shiz
  services = {
    xrdp = {
      enable = false;
      # defaultWindowManager = "${pkgs.i3}/bin/i3";
    };
    murmur = {
      enable = true;
      bandwidth = 130000;
    };
    pipewire.lowLatency.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      displayManager = {
        setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-1 --primary --mode 1920x1080 --rate 240 --output HDMI-A-0 --left-of DisplayPort-1";
        sddm = {
          enable = true;
          theme = "chili";
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
    # nvidia.modesetting.enable = true;
    opengl.extraPackages = with pkgs; [
      # nvidia-vaapi-driver
      # vaapiVdpau
      # libvdpau-va-gl
    ];
  };

  # virtualisation.podman.enableNvidia = true;

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
      # BUG
      # Vaapi is currently broken on my system
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
