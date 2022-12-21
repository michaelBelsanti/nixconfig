# System configuration module for Hyprland using official flake

# TODO
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia

{ lib, config, pkgs, ... }: {
  imports = [ ../default.nix ];
  config = lib.mkIf config.programs.hyprland.enable {
    programs.hyprland.recommendedEnvironment = true;
    services.xserver.displayManager.defaultSession = "hyprland";
    environment.systemPackages = with pkgs; [
      swaybg
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      brightnessctl
      wl-clipboard
      rofi-wayland
      grim
      slurp
      swaylock
    ];

    # hardware.nvidia.modesetting.enable = true;
    # environment.variables = {
    #   LIBVA_DRIVER_NAME = "nvidia";
    # CLUTTER_BACKEND = "wayland";
    # XDG_SESSION_TYPE = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # MOZ_ENABLE_WAYLAND = "1";
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_BACKEND = "vulkan";
    # QT_QPA_PLATFORM = "wayland";
    # GDK_BACKEND = "wayland";
    # };
  };
}
