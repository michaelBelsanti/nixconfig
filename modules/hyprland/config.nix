{ config, pkgs, ...}:
{
  imports = [ ../waybar ];
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
    recursive = true;
  };
}
