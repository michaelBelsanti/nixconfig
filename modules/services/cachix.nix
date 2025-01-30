{ delib, host, ... }:
delib.module {
  name = "services.cachix";
  options = delib.singleEnableOption host.isDesktop;
  nixos.ifEnabled = {
    services.cachix-watch-store = {
      enable = true;
      cacheName = "quasigod";
      cachixTokenFile = "/var/lib/secret/cachix.txt";
    };
  };
}
