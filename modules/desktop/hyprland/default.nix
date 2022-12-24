# System configuration module for Hyprland using official flake

# TODO
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia

{ pkgs, user, ... }: {
  imports = [ ../. ];
  programs.hyprland.recommendedEnvironment = true;
  # services.xserver.displayManager.defaultSession = "hyprland";
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
  home-manager.users.${user}.imports = [ ../rofi ];
}
