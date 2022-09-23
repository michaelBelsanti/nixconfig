{ config, pkgs, user, ... }:

{
  imports = 
    [
      ../../modules/hyprland/config
      ../../modules/zsh/laptop
    ];
  home.file = { };
}
