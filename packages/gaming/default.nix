{ pkgs, lib, user, ... }:
{
  environment.systemPackages = with pkgs; [
    gamescope
    winetricks
    protontricks
    vinegar
    (lutris.override {
      lutris-unwrapped = lutris-unwrapped.override { wine = wine-tkg; };
      extraLibraries = pkgs: [ latencyflex ];
    })
    heroic
    goverlay
    mangohud
    prismlauncher
    lunar-client
    minetest
    protonup-qt
  ];

  hardware = {
    xone.enable = true;
    # xpadneo.enable = true;
  };
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      package = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.latencyflex ];
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
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
          amd_performance_level = "high";
        };
      };
    };
  };
  home-manager.users.${user} = {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ obs-nvfbc obs-vkcapture obs-pipewire-audio-capture obs-gstreamer input-overlay ];
    };
  };
}
