# System configuration module for Hyprland using official flake

# TODO
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia

{ pkgs, user, ... }: {
  imports = [ ../. ];
  programs.hyprland.enable = true;
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };
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
  home-manager.users.${user} = {
    imports = [ ../rofi ];
    services.mako.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      recommendedEnvironment = true;
    };
  };
}
