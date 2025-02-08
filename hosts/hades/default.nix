{ delib, pkgs, inputs, ... }:
delib.host {
  name = "hades";
  rice = "catppuccin";
  type = "desktop";

  displays = {
    DP-1 = {
      primary = true;
      refreshRate = 240;
      width = 1920;
      height = 1080;
    };
    HDMI-A-1 = {
      refreshRate = 60;
      width = 1920;
      height = 1080;
      x = -1920;
    };
  };

  myconfig = {
    desktops.cosmic.enable = true;
    programs = {
      scrobbler.enable = true;
      easyeffects.enable = true;
    };
    gaming = {
      enable = true;
      replays = {
        enable = true;
        portal = false;
        screen = "DP-1";
      };
    };
  };

  nixos = {
    imports = with inputs; [
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-pc-ssd
    ];

    hardware = {
      keyboard.qmk.enable = true;
      amdgpu.opencl.enable = true;
    };

    networking = {
      hostName = "hades";
      useNetworkd = true;
      firewall = {
        enable = false;
        allowedUDPPorts = [
          3074 # BO2
          24872 # Yuzu
        ];
      };
    };

    services = {
      btrfs.autoScrub.enable = true;
      libinput.mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
      openssh = {
        enable = true;
        ports = [ 42069 ];
        settings.PasswordAuthentication = false;
      };
    };
  };
}
