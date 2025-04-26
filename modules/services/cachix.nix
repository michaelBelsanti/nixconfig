{
  mylib,
  config,
  lib,
  ...
}:
{
  options.services.cachix.enable = mylib.mkEnabledIf "desktop";
  config.nixos.services.cachix-watch-store = lib.mkIf config.services.cachix.enable {
    enable = true;
    cacheName = "quasigod";
    cachixTokenFile = "/var/lib/secret/cachix.txt";
  };
}
