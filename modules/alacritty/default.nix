{ config, pkgs, ...}:
{
  programs.alacritty.enable = true;
  xdg.configFile."alacritty" = {
    source = ./config;
    recursive = true;
  };
}
