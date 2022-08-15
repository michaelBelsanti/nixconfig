{ config, pkgs, ...}:
{
  xdg.configFile."hypr" = {
    source = ./hypr;
    recursive = true;
  };
}
