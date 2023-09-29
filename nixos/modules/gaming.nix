{
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gamescope
    winetricks
    protontricks
    (lutris.override {
      # extraPkgs = _pkgs: [wine-ge];
      extraLibraries = _pkgs: [latencyflex];
    })
    heroic
    goverlay
    mangohud
    prismlauncher
    lunar-client
    minetest
    osu-lazer-bin
    protonup-qt
    steamtinkerlaunch
    yuzu-mainline
    cartridges
    # BROKEN
    # gpu-screen-recorder
    # gpu-screen-recorder-gtk
  ];

  chaotic.steam.extraCompatPackages = with pkgs; [
    luxtorpeda
    steamtinkerlaunch
  ];
  hardware = {
    # xone.enable = true; # BUG broken package
    # xpadneo.enable = true;
  };
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      package = pkgs.steam.override {
        extraLibraries = pkgs: [pkgs.latencyflex];
      };
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
      plugins = with pkgs.obs-studio-plugins; [obs-nvfbc obs-vkcapture obs-pipewire-audio-capture obs-gstreamer input-overlay];
    };
  };
}
