# Services that don't need much configuration and won't need to be explicitly disabled on any systems.
{ delib, ... }:
delib.module {
  name = "services";

  home.always = {
    services = {
      ssh-agent.enable = true;
    };
  };

  nixos.always = {
  };
}
