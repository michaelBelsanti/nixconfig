# Services that don't need much configuration and won't need to be explicitly disabled on any systems.
{ pkgs, ... }:
{
  home.services = {
    ssh-agent.enable = true;
    pueue.enable = true;
  };
  nixos.services = {
    dbus.implementation = "broker";
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
