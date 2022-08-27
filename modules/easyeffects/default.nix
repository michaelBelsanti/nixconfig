{ config, pkgs, ...}:
{
  xdg.configFile."easyeffects" = {
    source = ./config;
    recursive = true;
  };
}
