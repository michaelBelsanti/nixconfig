{ inputs, config, ... }:
{
  unify.hosts.hades = {
    tags = [
      "desktop"
      "workstation"
      "gaming"
      "replays"
      "hacking"
      "virtualisation"
      "plymouth"
    ];

    primaryDisplay = config.unify.hosts.hades.displays.DP-1;
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

    nixos =
      { pkgs, ... }:
      {
        facter.reportPath = ./facter.json;
        imports = with inputs.nixos-hardware.nixosModules; [
          common-cpu-amd
          common-gpu-amd
          common-pc-ssd
        ];

        hardware = {
          keyboard.zsa.enable = true;
          keyboard.qmk.enable = true;
          amdgpu.opencl.enable = true;
        };

        environment.systemPackages = with pkgs; [
          keymapp
          wally-cli
        ];

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
  };
}
