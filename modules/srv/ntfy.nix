{
  delib,
  mylib,
  ...
}:
delib.module {
  name = "srv.ntfy";
  options.srv.ntfy = with delib; {
    enable = boolOption false;
    port = intOption 6996;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      services = {
        ntfy-sh = {
          enable = true;
          settings = {
            base-url = "https://ntfy.quasi.lol";
            listen-http = ":${toString cfg.port}";
            behind-proxy = true;
            auth-default-access = "deny-all";
          };
        };
        caddy.virtualHosts."ntfy.quasi.lol" = mylib.caddy.mkReverseProxy { inherit (cfg) port; };
      };
    };
}
