{ config, pkgs, inputs, ... }:
{
  imports = [
    ../system
    ../home
    ../../gaming
    ../../programming
  ];
  
  environment.systemPackages = with pkgs; [
    pciutils
  ];
}
