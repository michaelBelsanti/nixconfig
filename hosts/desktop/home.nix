{ config, pkgs, user, ... }:
{
  imports = 
    [
      ../../modules/zsh/desktop
      ../../modules/easyeffects
      ../../modules/i3/config
      ../../modules/dunst
      ../../modules/polybar
    ];
    
    xsession.initExtra = ''
      easyeffects --gapplication-service &
      xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4
    '';
}
