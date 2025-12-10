{
  styx,
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
    includes = with styx; [
      desktop
      hax
      gaming._.max
      ai._.ollama
      apps._.radicle
      apps._.zsa
      # (pipewire._.lowlatency {
      #   quantum = 48000;
      #   rate = 128;
      # })
    ];

    nixos =
      { pkgs, ... }:
      {
        facter.reportPath = ./_facter.json;
        facter.detected.dhcp.interfaces = [ "eth0" ];

        imports = with inputs; [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          # nix-gaming.nixosModules.pipewireLowLatency
        ];

        hardware.amdgpu.opencl.enable = true;
        nixpkgs.config.rocmSupport = true;
        environment.sessionVariables.HSA_OVERRIDE_GFX_VERSION = "11.0.1";
        services = {
          resolved.fallbackDns = [ ];
          fwupd.enable = true;
        };

        boot.kernelPackages =
          inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-latest;

        networking = {
          networkmanager.unmanaged = [ "eth0" ];
          hostName = "hades";
          firewall = {
            allowedUDPPorts = [
              3074 # BO2
              24872 # Yuzu
            ];
          };
        };
      };
  };
}
