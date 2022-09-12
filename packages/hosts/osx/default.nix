{ config, pkgs, ... }:
{
  imports = [
    ../../cli
    ../../programming
  ];
  
  environment.systemPackages = with pkgs; [
  ];
}
