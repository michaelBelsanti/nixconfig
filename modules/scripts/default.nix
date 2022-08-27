{ config, pkgs, ...}:
{
  home.file.".scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
