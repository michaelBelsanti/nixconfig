{ config, pkgs, ... }:
{
  imports = [
    ../../cli
    ../../gui
    ../../gaming
    ../../programming
  ];
  
  environment.systemPackages = with pkgs; [
    pciutils
  ];
}
