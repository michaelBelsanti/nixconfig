{ unify, host, ... }:
unify.module {
  name = "services.cachix";
  options = unify.singleEnableOption host.isDesktop;
  nixos.ifEnabled = {
    services.cachix-watch-store = {
      enable = true;
      cacheName = "quasigod";
      cachixTokenFile = "/var/lib/secret/cachix.txt";
    };
  };
}
