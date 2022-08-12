{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    swaybg
  ];
}
