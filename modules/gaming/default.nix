{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "gaming";
  options = delib.singleEnableOption false;
  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      # Games
      luanti
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin

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
      nexusmods-app

      # Emulation
      dolphin-emu
      dolphin-emu-primehack

      gpu-screen-recorder
      gpu-screen-recorder-gtk
    ];
    # Allows gpu-screen-recorder to record screens without escalating
    hardware.opentabletdriver.enable = true;
    programs = {
      gamescope.enable = true;
      steam = {
        package = pkgs.steam.override {
          # https://github.com/ValveSoftware/steam-for-linux/issues/11446
          extraEnv.LD_PRELOAD = "";
        };
        enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        # extraPackages = with pkgs; [ latencyflex ];
        gamescopeSession = {
          enable = true;
          args = [ "--adaptive-sync" ];
        };
      };
    };
  };
  home.ifEnabled = {
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
}
