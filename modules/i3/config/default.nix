{ config, pkgs, ...}:
{
  xdg.configFile."i3" = {
    source = ./config;
    recursive = true;
    target = "i3/config";
  };
  
  
}
