{ config, pkgs, ... }:
{
  imports = 
    [
      ../../packages/desktop/user.nix
      ../../modules/zsh/desktop
      ../../modules/easyeffects
      ../../modules/i3
      ../../modules/dunst
      ../../modules/polybar
    ];
  home.file.".xprofile".text = "xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4";
}
