{ config, pkgs, ... }:

{
  imports = 
    [
      ../../packages/laptop/user.nix
      ../../modules/hyprland/config.nix
    ];
  home.file = { };
}
