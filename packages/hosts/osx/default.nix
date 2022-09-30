{ config, pkgs, ... }:
{
  imports = [
    ../../cli
  ];
  
  environment.systemPackages = with pkgs; [
    alacritty
  ];
}
