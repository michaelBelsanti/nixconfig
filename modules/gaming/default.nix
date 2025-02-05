{
  delib,
  pkgs,
  inputs,
  host,
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
    environment.systemPackages = with pkgs; [
      # Launchers
      cartridges
      heroic
      lunar-client
      lutris
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
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          steamtinkerlaunch
          inputs.mypkgs.packages.${pkgs.system}.proton-cachyos
        ];
        gamescopeSession. enable = true;
      };
      gamescope = {
        enable = true;
        args = [
          "-W ${toString host.primaryDisplay.width}"
          "-W ${toString host.primaryDisplay.height}"
          "-r ${toString host.primaryDisplay.refreshRate}"
          "-O ${host.primaryDisplay.name}"
          "-f"
          "--adaptive-sync"
          "--mangoapp"
        ];
      };
    };
  };
  home.ifEnabled = {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-nvfbc
        obs-vkcapture
        obs-pipewire-audio-capture
        obs-gstreamer
        input-overlay
        obs-backgroundremoval
      ];
    };
  };
}
