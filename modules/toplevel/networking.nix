{
  unify = {
    modules.remote.nixos.services.tailscale = {
      extraSetFlags = [
        "--accept-routes"
        "--accept-dns"
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
          firewall.trustedInterfaces = [ "tailscale0" ];
        };
        # nixpkgs #180175
        systemd.services.NetworkManager-wait-online.enable = false;
        systemd.network.wait-online.enable = false;
      };
  };
}
