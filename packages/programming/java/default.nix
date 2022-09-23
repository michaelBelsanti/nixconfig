{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
    jetbrains.jdk
    staruml
    jdk11
  ];
}