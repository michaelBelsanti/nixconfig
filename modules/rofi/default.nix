{ config, pkgs, ...}:
{
  xdg.configFile."rofi" = {
    source = ./rofi;
    recursive = true;
  };
}
