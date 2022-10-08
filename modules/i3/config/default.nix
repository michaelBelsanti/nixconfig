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
  home.packages = with pkgs; [
  (writeScriptBin "togpicom" ''
    pgrep -x picom
    if [ $? -ne 0 ]
    then
        picom --unredir-if-possible --experimental-backends
    else
        pkill picom
    fi;
    '')
  ];
}
