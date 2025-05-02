{
  delib,
  pkgs,
  inputs,
  ...
}:
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

  shared.myconfig.services.syncthing.devices.hades.id =
    "EI3OAYC-BEJG55M-AP5OIOR-ZVDT5UE-P2GBSEY-7UJIQEQ-2IJ5CZ2-FSG6EQF";

  myconfig = {
    nix.lix.enable = true;
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
  };

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "22.05";

  nixos = {
    system.stateVersion = "22.05";
    imports = with inputs; [
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-pc-ssd
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
    boot.kernelPackages = inputs.chaotic.legacyPackages.${pkgs.system}.linuxPackages_cachyos;

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
}
