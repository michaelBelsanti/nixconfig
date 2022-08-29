{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Work
    slack
    thunderbird
  ];
}
