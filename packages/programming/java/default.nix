{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
    staruml
    jdk11
  ];
}