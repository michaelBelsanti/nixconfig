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

  # Display shiz
  services = {
    murmur = {
      enable = true;
      bandwidth = 130000;
    };
    pipewire.lowLatency.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      displayManager = {
        # setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-1 --primary --mode 1920x1080 --rate 240 --output HDMI-A-0 --left-of DisplayPort-1";
        sddm = {
          enable = true;
          wayland.enable = true;
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
  };


  environment = {
    systemPackages = with pkgs; [
      # (sddm-chili-theme.override {
      #   themeConfig = {
      #     ScreenWidth = 1920;
      #     ScreenHeight = 1080;
      #     background = pkgs.rosepine-wallpaper;
      #   };
      # })
    ];
    sessionVariables = {
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
