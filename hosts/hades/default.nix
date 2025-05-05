{ pkgs, inputs, ... }:
{
  host.hades = {
    tags = [
      "desktop"
      "workstation"
      "gaming"
    ];

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

    desktops.cosmic.enable = true;
    programs = {
      shells = {
        nushell.default = true;
        fish.default = false;
      };
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

    home.home.stateVersion = "22.05";

    nixos = {
      system.stateVersion = "22.05";
      imports = with inputs.nixos-hardware.result.nixosModules; [
        common-cpu-amd
        common-gpu-amd
        common-pc-ssd
      ];

      facter.reportPath = ./facter.json;
      hardware = {
        keyboard.zsa.enable = true;
        keyboard.qmk.enable = true;
        amdgpu.opencl.enable = true;
      };

      environment.systemPackages = with pkgs; [
        keymapp
        wally-cli
      ];

      # boot.kernelPackages = pkgs.linuxPackages_6_11;
      boot.kernelPackages = inputs.chaotic.result.legacyPackages.${pkgs.system}.linuxPackages_cachyos;

      networking = {
        hostName = "hades";
        firewall = {
          allowedUDPPorts = [
            3074 # BO2
            24872 # Yuzu
          ];
        };
      };

      services = {
        ollama = {
          enable = true;
          acceleration = "rocm";
          rocmOverrideGfx = "11.0.1";
          user = "ollama";
        };
        open-webui = {
          enable = true;
          port = 8008;
          environment.WEBUI_AUTH = "False";
        };
        openssh = {
          enable = true;
          ports = [ 42069 ];
          settings.PasswordAuthentication = false;
        };
      };
    };
  };

  services.syncthing.devices.hades.id =
    "EI3OAYC-BEJG55M-AP5OIOR-ZVDT5UE-P2GBSEY-7UJIQEQ-2IJ5CZ2-FSG6EQF";
}
