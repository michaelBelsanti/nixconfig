{ config, pkgs, ... }:

{
  imports = 
    [
      ../../modules/hyprland/config.nix
      ../../modules/zsh/laptop
    ];
  home.file = { };
}
