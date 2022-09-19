{ config, pkgs, ...}:
{
  xdg.configFile."i3" = {
    source = ./config;
    target = "i3/config";
  };
    xdg.configFile."picom" = {
    source = ./picom.conf;
    target = "picom/picom.conf";
  };
}
