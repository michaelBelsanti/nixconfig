{
  pkgs,
  inputs,
  host,
  mylib,
  config,
  lib,
  ...
}:
{
  options.gaming.enable = mylib.mkBool false;
  config = lib.mkIf config.gaming.enable {
    nixos = {
      chaotic.nyx.overlay.enable = true;
      environment.systemPackages = with pkgs; [
        # Launchers
        cartridges
        heroic
        lunar-client
        (lutris.override {
          extraPkgs = pkgs: [ umu-launcher ];
          extraLibraries = pkgs: [ pkgs.latencyflex-vulkan ];
        })
        prismlauncher
        umu-launcher

        # Utility
        goverlay
        mangohud
        protontricks
        protonplus
        r2modman
        winetricks
        ludusavi
        nexusmods-app
        latencyflex-vulkan

        # Recording
        gpu-screen-recorder
        gpu-screen-recorder-gtk
      ];
      # Allows gpu-screen-recorder to record screens without escalating
      hardware = {
        opentabletdriver.enable = true;
        graphics.enable32Bit = true;
      };
      services = {
        pipewire.lowLatency.enable = true;
        input-remapper.enable = true;
        system76-scheduler.enable = true;
      };
      programs = {
        steam = {
          enable = true;
          platformOptimizations.enable = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraPackages = [ pkgs.latencyflex-vulkan ];
          extraCompatPackages = with pkgs; [
            proton-ge-bin
            steamtinkerlaunch
            inputs.mypkgs.result.packages.${pkgs.system}.proton-cachyos
          ];
        };
        gamescope = {
          enable = true;
          args = [
            "-W ${toString host.primaryDisplay.width}"
            "-H ${toString host.primaryDisplay.height}"
            "-r ${toString host.primaryDisplay.refreshRate}"
            "-O ${host.primaryDisplay.name}"
            "-f"
            "--adaptive-sync"
            "--mangoapp"
          ];
        };
      };
    };
    home.programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-pipewire-audio-capture
        obs-gstreamer
        input-overlay
        obs-backgroundremoval
      ];
    };
  };
}
