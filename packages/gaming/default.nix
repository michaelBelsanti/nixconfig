{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (self: super: # Overlay to allow Overwatch to run with caffe runner
      { lutris = super.lutris.override { extraLibraries = pkgs: [pkgs.libunwind ]; }; })
  ];
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
    gamescope
    winetricks
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
