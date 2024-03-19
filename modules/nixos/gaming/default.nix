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
      protonup-qt
      r2modman
      steamtinkerlaunch
      winetricks

      # Emulation
      dolphin-emu
      dolphin-emu-primehack
      ssbm.slippi-launcher
      ssbm.slippi-netplay
    ];

    chaotic.steam.extraCompatPackages = with pkgs; [
      nyx.luxtorpeda
      steamtinkerlaunch
    ];
    hardware = {
      opentabletdriver.enable = true;
      # xone.enable = true; # BUG broken package
      # xpadneo.enable = true;
    };
    ssbm.cache.enable = true;
    programs = {
      gamescope.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        package = pkgs.steam.override {
          # extraLibraries = pkgs: [pkgs.latencyflex];
        };
        gamescopeSession.enable = true;
      };
      gamemode = {
        enable = true;
        settings = {
          custom = {
            start = "togdnd -p; polybar-msg action gamemode module_show";
            end = "togdnd -u; polybar-msg action gamemode module_hide";
          };
          general = {
            reaper_freq = 5;
            defaultgov = "performance";
            softrealtime = "auto";
            renice = 0;
            ioprio = 0;
          };
          # gpu = {
          #   apply_gpu_optimisations = "accept-responsibility";
          #   gpu_device = 0;
          #   nv_powermizer_mode = 1;
          #   amd_performance_level = "high";
          # };
        };
      };
    };
    snowfallorg.users.${user}.home.config = {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-nvfbc
          obs-vkcapture
          obs-pipewire-audio-capture
          obs-gstreamer
          input-overlay
        ];
      };
    };
  };
}
