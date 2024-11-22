{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ./hardware.nix ];

  home-manager.users.${config.users.mainUser} = {
    apps.scrobbler.enable = true;
    home.packages = with pkgs; [ custom.obs-cmd ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "mpvpaper -p DP-2 -o 'loop-file' ${pkgs.wallpapers.live.chainsawman}"
        "mpvpaper -p HDMI-A-1 -o 'loop-file' ${pkgs.wallpapers.live.killua}"
        "hyprctl setcursor Posy_Cursor 32"
        "obs --startreplaybuffer --minimize-to-tray --disable-shutdown-check"
      ];

      bind = [ "SUPER,v,exec,obs-cmd replay save && notify-send 'OBS Replay Buffer Saved!'" ];

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

  # boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.loader.systemd-boot = {
    enable = true;
    netbootxyz.enable = true;
  };
  # chaotic.scx.enable = true; # by default uses scx_rustland scheduler

  # Custom options
  desktop = {
    cosmic.enable = true;
  };

  gaming.enable = true;
  apps.unmanic.enable = true;
  programs.steam.gamescopeSession.args = [ "--adaptive-sync --display-index 2" ];

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
    libinput.mouse = {
      accelProfile = "flat";
      middleEmulation = false;
    };
    pipewire.lowLatency.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
    openssh = {
      enable = true;
      ports = [ 42069 ];
      settings.PasswordAuthentication = false;
    };
    ollama = {
      enable = true;
      acceleration = "rocm";
      loadModels = [
        "llama3.1"
        "mistral-nemo"
      ];
    };
    # open-webui.enable = true;
  };

  hardware = {
    keyboard.qmk.enable = true;
    amdgpu.opencl.enable = true;
  };

  environment = {
    sessionVariables = {
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableKvm = true;

  system.stateVersion = "22.05"; # Did you read the comment?
}
