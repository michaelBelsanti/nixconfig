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
          # falcond = {
          #   enable = true;
          #   package = pkgs.falcond.overrideAttrs (finalAttrs: {
          #     src = pkgs.fetchFromGitHub {
          #       owner = "michaelBelsanti";
          #       repo = "falcond";
          #       rev = "38e9a823ff31b47671a7d209cc69f9d7c27f637a";
          #       hash = "sha256-ZNifsY3eut78Hg+xZ5A8I4h1NJqRTnfDE4OfOi/gu6Q=";
          #       rootDir = "falcond";
          #     };
          #   });
          #   configText = ''
          #     scx_sched = cake
          #     vcache_mode = freqency
          #   '';
          #   profiles.deadlock = ''
          #     name = "deadlock.exe"
          #     scx_sched_props = latency
          #   '';
          # };
          # scx-loader = {
          #   enable = true;
          #   schedsPackages = [
          #     (inputs.scx_cake.packages.${pkgs.stdenv.hostPlatform.system}.scx_cake)
          #   #   (pkgs.scx.rustscheds.overrideAttrs (
          #   #     final: prev: {
          #   #       src = pkgs.fetchFromGitHub {
          #   #         owner = "sched-ext";
          #   #         repo = "scx";
          #   #         rev = "0f379644a0e2d31986fde8f2faf76f85717207d9";
          #   #         hash = "sha256-JqTq000cAHp2F66Q/z9yFAVrLNdOteqxGhEE1rMjijk=";
          #   #       };
          #   #       doCheck = false;
          #   #       cargoDeps = prev.cargoDeps.overrideAttrs (prev': {
          #   #         vendorStaging = prev'.vendorStaging.overrideAttrs {
          #   #           inherit (final) src;
          #   #           outputHash = "sha256-wdo127ngL1h4oiFK7ryLb0/qqx6IuZyDBu34DzDmiaE=";
          #   #         };
          #   #       });
          #   #     }
          #   #   ))
          #   ];
          #   settings = { };
          #   package = pkgs.scx.loader.overrideAttrs (
          #     final: prev: {
          #       src = pkgs.fetchFromGitHub {
          #         owner = "sched-ext";
          #         repo = "scx-loader";
          #         rev = "0a52e98197721b396bdbc1632b8e35e8f6b27a03";
          #         hash = "sha256-skKJiXMrFxRrhnxgE/dtrFda0v9Qy10zqSTVJoQblsk=";
          #       };
          #     }
          #   );
          # };
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
