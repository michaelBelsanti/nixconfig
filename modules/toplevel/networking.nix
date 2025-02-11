{ delib, lib, ... }:
delib.module {
  name = "networking";
  nixos.always = {
    networking = {
      useNetworkd = true;
      nftables.enable = true;
      wireguard.enable = true;
      firewall.interfaces.tailscale0.allowedUDPPortRanges = lib.singleton {
        from = 0;
        to = 65535;
      };
      firewall.interfaces.tailscale0.allowedTCPPortRanges = lib.singleton {
        from = 0;
        to = 65535;
      };
    };
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
  };
}
