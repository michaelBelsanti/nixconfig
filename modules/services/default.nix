{
  unify = {
    home.services = {
      ssh-agent.enable = true;
      pueue.enable = true;
    };
    nixos =
      { pkgs, ... }:
      {
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
  };
}
