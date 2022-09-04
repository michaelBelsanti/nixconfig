{ config, pkgs, ...}:
{
  xdg.configFile."btop" = {
    source = ./config;
    recursive = true;
  };
}
