{ delib, ... }:
delib.module {
  name = "srv.rustdesk";
  options = delib.singleEnableOption false;
  nixos.ifEnabled.services = {
    rustdesk-server = {
      enable = true;
      signal.relayHosts = [ "localhost" ];
      openFirewall = true;
    };
  };
}
