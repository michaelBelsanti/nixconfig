# System configuration module for Hyprland using official flake

# TODO
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia

{ inputs, pkgs, user, ... }: {
  imports = [ ../. ];
  programs.hyprland = {
    enable = true;
    xwayland.hidpi = true;
  };
  services.xserver.displayManager.defaultSession = "hyprland";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
  };
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    swaybg
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    brightnessctl
    wl-clipboard
    rofi-wayland
    grimblast
    swaylock
  ];
  home-manager.users.${user} = {
    imports = [ ../rofi ../../terminal/foot ];
    services.mako.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      recommendedEnvironment = true;
    };
  };
}
