{ config, pkgs, ...}:
{
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./hyprland.conf;
      recursive = true;
    };
    "waybar" = {
      source = ./waybar;
      recursive = true;
    };
  };
}
