{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
    gamescope
    winetricks
    protontricks
    grapejuice
    gamemode
    (lutris.override {extraLibraries = pkgs: [pkgs.libunwind ];})
    heroic
    goverlay
    mangohud
  ];

  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  hardware.steam-hardware.enable = true;
}
