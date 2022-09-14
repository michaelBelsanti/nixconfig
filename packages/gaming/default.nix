{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gamescope
    vulkan-loader
    protontricks
    grapejuice
    gamemode
  ];

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
}
