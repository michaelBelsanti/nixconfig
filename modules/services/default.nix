# Services that don't need much configuration and won't need to be explicitly disabled on any systems.
{ delib, pkgs, ... }:
delib.module {
  name = "services";

  home.always = {
    services = {
      ssh-agent.enable = true;
      pueue.enable = true;
    };
  };

  nixos.always = {
    services = {
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
  };
}
