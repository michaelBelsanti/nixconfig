{
  styx,
  config,
  inputs,
  lib,
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

  den.hosts.x86_64-linux.hades = {
    inherit (config.hostConfig.hades) displays primaryDisplay;
    instantiate =
      args: inputs.nixpkgs-patcher.lib.nixosSystem ({ nixpkgsPatcher.inputs = inputs; } // args);
  };
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
          falcond = {
            enable = true;
            settings = {
              scx_sched = "cake";
              # start_script = toString (
              #   pkgs.writeScript "falcond_start" ''
              #     #!${lib.getExe pkgs.nushell}
              #     if not (dms ipc call notifications getDoNotDisturb | into bool) then {
              #       dms ipc call notifications toggleDoNotDisturb
              #     }
              #   ''
              # );
              # stop_script = toString (
              #   pkgs.writeScript "falcond_stop" ''
              #     #!${lib.getExe pkgs.nushell}
              #     if (dms ipc call notifications getDoNotDisturb | into bool) then {
              #       dms ipc call notifications toggleDoNotDisturb
              #     }
              #   ''
              # );
            };
            profiles.deadlock = {
              name = "deadlock.exe";
              scx_sched_props = "lowlatency";
            };
          };
          scx-loader = {
            enable = true;
            schedsPackages = [ inputs.scx_cake.packages.${pkgs.stdenv.hostPlatform.system}.scx_cake ];
            settings = { };
            package = pkgs.scx.loader.overrideAttrs (
              final: prev: {
                src = pkgs.fetchFromGitHub {
                  owner = "michaelBelsanti";
                  repo = "scx-loader";
                  rev = "70064e94d51ea56a6f2fed0368cf787b03c60e96";
                  hash = "sha256-LQCfM7z57kVxRBY3GJJFUbopefoyRvQLt+MLJjuWmMY=";
                };
              }
            );
          };
        };

        security.rtkit.enable = true;

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

        programs.obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            obs-multi-rtmp
            obs-vkcapture
            obs-tuna
            obs-gstreamer
            wlrobs
          ];
        };

        # services.scx.scheduler uses an enum with the upstream schedulers hardcoded
        # systemd.services.scx =
        #   let
        #     scx_cake = inputs.scx_cake.packages.${pkgs.stdenv.hostPlatform.system}.scx_cake;
        #   in
        #   {
        #     description = "SCX scheduler daemon";
        #     # SCX service should be started only if the kernel supports sched-ext
        #     unitConfig.ConditionPathIsDirectory = "/sys/kernel/sched_ext";
        #     startLimitIntervalSec = 30;
        #     startLimitBurst = 2;
        #     serviceConfig = {
        #       Type = "simple";
        #       ExecStart = ''
        #         ${pkgs.runtimeShell} -c 'exec ${scx_cake}/bin/scx_cake'
        #       '';
        #       Restart = "on-failure";
        #     };
        #     wantedBy = [ "multi-user.target" ];
        #   };

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
