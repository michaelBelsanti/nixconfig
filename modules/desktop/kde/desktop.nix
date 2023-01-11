{ pkgs, user, ... }:
{
  imports = [ ./. ];
  environment.systemPackages = with pkgs; [
    xclip
  ];
}
