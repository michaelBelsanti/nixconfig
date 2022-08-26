{ config, pkgs, ...}:
{
  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };
}
