{ config, pkgs, ...}:
{
  xdg.configFile."polybar" = {
    source = ./config;
    recursive = true;
  };
}
