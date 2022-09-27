{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gamescope
    protontricks
    grapejuice
    gamemode
    lutris
    heroic
    goverlay
    mangohud
  ];

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  hardware.steam-hardware.enable = true;
}
