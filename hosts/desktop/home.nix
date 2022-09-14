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
}
