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
      protonplus
      r2modman
      winetricks
      ludusavi

      # Emulation
      dolphin-emu
      dolphin-emu-primehack
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
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-nvfbc
          # obs-vkcapture
          obs-pipewire-audio-capture
          obs-gstreamer
          input-overlay
        ];
      };
    };
  };
}
