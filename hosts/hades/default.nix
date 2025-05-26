{ inputs, config, ... }:
{
  unify.hosts.hades = {
    tags = [
      "workstation"
      "gaming"
      "replays"
      "hacking"
      "virtualisation"
      "cachix"
      "localai"
      "zsa-kb"
    ];

    primaryDisplay = config.unify.hosts.hades.displays.DP-3;
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

    nixos =
      { pkgs, ... }:
      {
        facter.reportPath = ./facter.json;
        imports = with inputs.nixos-hardware.nixosModules; [
          common-cpu-amd
          common-gpu-amd
          common-pc-ssd
        ];

        hardware.amdgpu.opencl.enable = true;

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
          ollama.rocmOverrideGfx = "11.0.1";
          openssh.ports = [ 42069 ];
        };
      };
  };
}
