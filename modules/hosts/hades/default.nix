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
        refresh = 239.760;
        width = 1920;
        height = 1080;
        vrr = true;
      };
      HDMI-A-1 = {
        refresh = 100.0;
        width = 1920;
        height = 1080;
        x = -1920;
        vrr = "on-demand";
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
          maccel.nixosModules.default
        ];
        nixpkgs.config.rocmSupport = true;
        environment.sessionVariables.HSA_OVERRIDE_GFX_VERSION = "11.0.1";
        services = {
          fwupd.enable = true;
          # firewalld.enable = true;
        };

        hardware = {
          amdgpu.opencl.enable = true;
          bluetooth.enable = true;
          maccel = {
            enable = true;
            enableCli = true;
            parameters = {
              sensMultiplier = 0.6;
              inputDpi = 800.0;
              mode = "natural";
              decayRate = 0.1;
              limit = 3.0;
            };
          };
        };

        boot.kernelPackages =
          inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-latest;

        virtualisation.docker.enable = true;
        users.users.quasi.extraGroups = [ "docker" ];

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
