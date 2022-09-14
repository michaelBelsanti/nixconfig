{ config, pkgs, user, ... }:

{
  imports = 
    [
      ../../modules/hyprland/config.nix
      ../../modules/zsh/laptop
    ];
  home.file = { };
}
