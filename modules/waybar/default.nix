{ config, pkgs, ...}:
{
  xdg.configFile."waybar" = {
    source = ./config;
    recursive = true;
  };
}
