{ config, pkgs, user, ... }:
{
  imports = 
    [
      ../home.nix
      ../../modules/hyprland/config
      ../../modules/zsh/laptop
    ];
  home.file = { };
}
