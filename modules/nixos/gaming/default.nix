{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.gaming;
  user = config.users.mainUser;
in
{
  options.gaming.enable = mkBoolOpt false "Enable all gaming packages and configurations.";
  options.gaming.replays.enable = mkBoolOpt false "Enable instant replays using gpu-screen-recorder.";
  options.gaming.replays.portal = mkBoolOpt false "Use portal for instant replays";
  options.gaming.replays.screen = mkBoolOpt false "Screen to be used for instant replays, if not using portal.";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Games
      minetest
      gaming.osu-lazer-bin

      # Launchers
      cartridges
      heroic
      lunar-client
      (lutris.override {
        extraPkgs = _pkgs: [ wineWowPackages.full ];
        # extraLibraries = pkgs: [latencyflex];
      })
      prismlauncher

      # Utility
      gamescope
      goverlay
      mangohud
      protontricks
      protonplus
      r2modman
      winetricks
      ludusavi

      # Emulation
      dolphin-emu
      dolphin-emu-primehack

      gpu-screen-recorder
      gpu-screen-recorder-gtk
    ];
    services.sunshine = {
      enable = false;
      openFirewall = true;
      applications.apps = lib.singleton {
        name = "Cartridges";
        cmd = "${lib.getExe pkgs.cartridges}";
      };
    };
    hardware = {
      opentabletdriver.enable = true;
    };
    programs = {
      gamescope.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        # extest.enable = true;
        # extraPackages = with pkgs; [ latencyflex ];
        gamescopeSession = {
          enable = true;
          args = [ "--adaptive-sync" ];
        };
      };
      gamemode = {
        enable = true;
        settings = {
          general = {
            reaper_freq = 5;
            defaultgov = "performance";
            softrealtime = "auto";
            renice = 0;
            ioprio = 0;
          };
        };
      };
    };
    snowfallorg.users.${user}.home.config = {
      systemd.user.services.gpu-screen-recorder-replay = {
        # Save a video using `killall -SIGUSR1 gpu-screen-recorder` (or any other way to send a SIGUSR1 signal to gpu-screen-recorder)
        Unit.Description = "gpu-screen-recorder replay service";
        Install.WantedBy = [ "default.target" ];
        Service = let
          w = if cfg.replays.portal then "portal" else cfg.replays.screen;
        in {
          ExecStartPre = "/usr/bin/env mkdir -p %h/Videos/Replays";
          ExecStart = "${lib.getExe pkgs.gpu-screen-recorder} -w ${w} -f 60 -r 60 -a 'default_output|default_input' -c mp4 -q very_high -o %h/Videos/Replays -restore-portal-session yes";
        };
      };
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-nvfbc
          # obs-vkcapture
          obs-pipewire-audio-capture
          obs-gstreamer
          input-overlay
          obs-backgroundremoval
        ];
      };
    };
  };
}
