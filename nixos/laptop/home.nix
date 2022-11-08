{ config, pkgs, user, flakePath, ... }:
{
  imports =
    [
      ../home.nix
      ../../modules/hyprland/config
      ../../modules/zsh/laptop
    ];
  home.file = { };
}
