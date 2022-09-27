{ config, pkgs, ...}:
{
  imports = [
    ../../rofi
  ];
  
  xdg.configFile = {
    i3 = {
      source = ./config;
      target = "i3/config";
    };
    picom = {
      source = ./picom.conf;
      target = "picom/picom.conf";
    };
    polybar = {
      source = ./polybar;
      recursive = true;
    };
  };
}
