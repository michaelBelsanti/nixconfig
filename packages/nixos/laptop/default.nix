{ config, pkgs, ... }:
{
  imports = [
    ../../gui
    ../../cli
    ../../programming
  ];

  environment.systemPackages = with pkgs; [
    # Work
    slack
    thunderbird
    brightnessctl
  ];
}
