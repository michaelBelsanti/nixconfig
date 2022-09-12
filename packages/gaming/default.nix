{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gamescope
    vulkan-loader
    protontricks
    grapejuice
    gamemode
  };
}
