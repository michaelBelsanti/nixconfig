{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
    jetbrains.jdk
    eclipses.eclipse-java
    staruml
    jdk11
  ];
}