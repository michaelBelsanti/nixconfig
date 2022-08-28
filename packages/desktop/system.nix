{ config, pkgs, ... }:
{
  imports = [
    ./overlays.nix
  ];

  environment.systemPackages = with pkgs; [
    pciutils
  ];
}
