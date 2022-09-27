{ config, pkgs, ...}:
{
  imports = [
    ../../rofi    
  ];

  xdg.configFile = {
    hyprland = {
      source = ./hyprland.conf;
      target = "hypr/hyprland.conf";
    };
    waybar = {
      source = ./waybar;
      recursive = true;
    };
  };
}
