{ pkgs, user, ... }:
{
  imports = [ ./. ];
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
