{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "gaming";
  options = delib.singleEnableOption false;
  nixos.always.imports = with inputs.nix-gaming.nixosModules; [
    pipewireLowLatency
    platformOptimizations
  ];
  nixos.ifEnabled = {
    nixpkgs.overlays = [ inputs.nix-gaming.overlays.default ];
    environment.systemPackages = with pkgs; [
      # Games
      luanti

      # Launchers
      cartridges
      heroic
      lunar-client
      lutris
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

      # Recording
      gpu-screen-recorder
      gpu-screen-recorder-gtk

      # nix-gaming
      osu-lazer-bin
      umu-launcher
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
      gamescope.enable = true;
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          steamtinkerlaunch
          inputs.mypkgs.packages.${pkgs.system}.proton-cachyos
        ];
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
