{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustc
    cargo
    gcc
    rust-analyzer
    taplo
  ];
}
