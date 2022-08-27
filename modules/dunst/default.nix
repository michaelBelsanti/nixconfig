{ config, pkgs, ...}:
{
  xdg.configFile."dunst" = {
    source = ./config;
    recursive = true;
  };
}
