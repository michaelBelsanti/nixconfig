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
  ] ++ [ inputs.chaotic.nixosModules.default ];
  nixos.ifEnabled = {
    chaotic.nyx.overlay.enable = true;
    environment.systemPackages = with pkgs; [
      # Launchers
      cartridges
      heroic
      lunar-client
      (lutris.override {
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
          inputs.mypkgs.packages.${pkgs.system}.proton-cachyos
        ];
        gamescopeSession.enable = true;
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
        obs-vkcapture
        obs-pipewire-audio-capture
        obs-gstreamer
        input-overlay
        obs-backgroundremoval
      ];
    };
  };
}
