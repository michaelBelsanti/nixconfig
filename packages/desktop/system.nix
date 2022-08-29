{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pciutils
  ];

  nixpkgs.overlays = [
    (self: super:
      { polybar = super.polybar.override { i3GapsSupport = true; pulseSupport = true; }; })
  ];
}
