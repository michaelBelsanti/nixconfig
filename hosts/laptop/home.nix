{ config, pkgs, ... }:

{
  imports = 
    [
      ../../packages/laptop/user.nix
      ../../modules/hyprland/config.nix
      ../../modules/zsh/laptop
    ];
  home.file = { };
}
