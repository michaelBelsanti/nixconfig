{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustc
    cargo
    rust-analyzer
    taplo
  ];
}
