{
  unify.modules.cachix.nixos =
    { config, ... }:
    {
      sops.secrets.cachix_token = { };
      services.cachix-watch-store = {
        enable = true;
        cacheName = "quasigod";
        cachixTokenFile = config.sops.secrets.cachix_token.path;
      };
    };
}
