{
  delib,
  mylib,
  config,
  ...
}:
delib.module {
  name = "srv.mollysocket";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # mollysocket uses a dynamic user
    # figure out a better way to make it readable
    sops.secrets.mollysocket_env = { };
    sops.secrets.mollysocket_env.mode = "0444";
    services = {
      mollysocket = {
        enable = true;
        environmentFile = "${config.sops.secrets.mollysocket_env.path}";
        settings = {
          allowed_uuids = [ "4e293ef7-6b21-4eb1-b37a-48591d12ed0e" ];
          allowed_endpoints = [ "https://ntfy.quasi.lol" ];
        };
      };
      caddy.virtualHosts."molly.quasi.lol" = mylib.caddy.mkReverseProxy {
        inherit (config.services.mollysocket.settings) port;
      };
    };
  };
}
