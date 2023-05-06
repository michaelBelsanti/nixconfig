# System configuration module for Hyprland using official flake

# TODO
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia

{ pkgs, user, ... }: {
  imports = [ ../. ./scripts.nix ];
  programs.hyprland = {
    enable = true;
    xwayland.hidpi = true;
  };
  services.xserver.displayManager.defaultSession = "hyprland";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
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
    brightnessctl
  ];
  home-manager.users.${user} = {
    imports = [ ../rofi ];
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
      font = "monospace 12";
      extraConfig = ''
        [mode=dnd]
        invisible=1
      '';
    };
    wayland.windowManager.hyprland = {
      enable = true;
      recommendedEnvironment = true;
    };
  };
}