{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gamescope
    vulkan-loader
    protontricks
    grapejuice
    gamemode
    lutris
    bottles
    pkgs.driversi686Linux.mesa
  ];

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  hardware.steam-hardware.enable = true;
}
