{
  unify = {
    nixos = {
      networking = {
        nftables.enable = true;
        wireguard.enable = true;
        firewall.trustedInterfaces = [ "podman0" ];
      };
      # nixpkgs #180175
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;
    };
    modules.server.nixos.networking.tempAddresses = "disabled";
  };
}
