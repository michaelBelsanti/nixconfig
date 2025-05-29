{ lib, ... }:
{
  unify = {
    modules.remote.nixos.services.tailscale = {
      extraSetFlags = [
        "--accept-routes"
        "--accept-dns=false"
      ];
    };
    nixos =
      { hostConfig, ... }:
      {
        services.tailscale = {
          enable = true;
          extraSetFlags = [ "--operator=${hostConfig.primaryUser}" ];
        };
        networking = {
          nftables.enable = true;
          wireguard.enable = true;
          firewall.interfaces.tailscale0 = {
            allowedUDPPortRanges = lib.singleton {
              from = 0;
              to = 65535;
            };
            allowedTCPPortRanges = lib.singleton {
              from = 0;
              to = 65535;
            };
          };
        };
        # nixpkgs #180175
        systemd.services.NetworkManager-wait-online.enable = false;
        systemd.network.wait-online.enable = false;
      };
  };
}
