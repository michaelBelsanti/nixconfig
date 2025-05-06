{
  unify.modules.desktop.nixos.services.cachix-watch-store = {
    enable = true;
    cacheName = "quasigod";
    cachixTokenFile = "/var/lib/secret/cachix.txt";
  };
}
