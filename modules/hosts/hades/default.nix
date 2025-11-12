{
  den,
  config,
  inputs,
  ...
}:
{
  hostConfig.hades = {
    primaryDisplay = config.hostConfig.hades.displays.DP-3;
    displays = {
      DP-3 = {
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
  };

  den.hosts.x86_64-linux.hades = { inherit (config.hostConfig.hades) displays primaryDisplay; };
  den.aspects.hades = {
    includes = with den.aspects; [
      desktop
      hax
      gaming._.min
      gaming._.max
      ai._.ollama
      apps._.radicle
      apps._.zsa
      services._.syncthing._.client
      (pipewire._.lowlatency {
        quantum = 256;
        rate = 48000;
      })
      # wayland
    ];

    nixos =
      { pkgs, ... }:
      {
        facter.reportPath = ./_facter.json;
        imports = with inputs; [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          # nix-gaming.nixosModules.pipewireLowLatency
        ];

        hardware.amdgpu.opencl.enable = true;
        nixpkgs.config.rocmSupport = true;
        environment.sessionVariables.HSA_OVERRIDE_GFX_VERSION = "11.0.1";

        # services.pipewire.lowLatency = {
        #   enable = true;
        #   rate = 48000;
        #   quantum = 256;
        # };

        boot.kernelPackages =
          inputs.chaotic.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages_cachyos;

        services.resolved.fallbackDns = [ ];
        systemd.network = {
          enable = true;
          links."01-ethernet" = {
            matchConfig.Type = "ether";
            linkConfig.WakeOnLan = "magic";
          };
          networks."01-ethernet" = {
            matchConfig.Name = "enp8s0";
            networkConfig.DHCP = "yes";
          };
        };

        networking = {
          networkmanager.enable = false;
          hostName = "hades";
          firewall = {
            allowedUDPPorts = [
              3074 # BO2
              24872 # Yuzu
            ];
          };
        };

        services.fwupd.enable = true;

      };
  };
}
