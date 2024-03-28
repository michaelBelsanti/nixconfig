{ config, ... }:
{
  imports = [ ./hardware.nix ];

  home-manager.users.${config.users.mainUser} = {
    # imports = [ ./plasma-manager.nix ];
    wayland.windowManager.hyprland.settings = {
      input = {
        accel_profile = "flat";
      };

      monitor = [
        "DP-2,highrr,0x0,1"
        "HDMI-A-1,1920x1080@60,-1920x0,1"
      ];

      workspace = [
        "1,monitor:DP-2"
        "2,monitor:DP-2"
        "3,monitor:DP-2"
        "4,monitor:DP-2"
        "5,monitor:DP-2"
        "6,monitor:DP-2"
        "7,monitor:DP-2"
        "8,monitor:DP-2"
        "9,monitor:DP-2"
        "11,monitor:HDMI-A-1,default:true"
        "12,monitor:HDMI-A-1"
        "13,monitor:HDMI-A-1"
        "14,monitor:HDMI-A-1"
        "15,monitor:HDMI-A-1"
        "16,monitor:HDMI-A-1"
        "17,monitor:HDMI-A-1"
        "18,monitor:HDMI-A-1"
        "19,monitor:HDMI-A-1"
      ];
    };
  };

  # Custom options
  desktop = {
    # gnome.enable = true;
    hyprland.enable = true;
    wayland.enable = true;
  };

  gaming.enable = true;
  # apps.unmanic.enable = true;

  networking = {
    hostName = "hades";
    # preferred for a wired connection
    useNetworkd = true;
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
    pipewire.lowLatency.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager.gdm.enable = true;
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

  hardware = {
    keyboard.qmk.enable = true;
  };

  environment = {
    sessionVariables = {
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
