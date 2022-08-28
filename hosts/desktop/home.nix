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
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    gtk.enable = true;
    x11.enable = true;
  };
}
