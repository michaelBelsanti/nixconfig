{
  styx.networking = {
    provides.static.nixos.networking.tempAddresses = "disabled";
    nixos.networking = {
      nftables.enable = true;
      wireguard.enable = true;
      firewall.trustedInterfaces = [ "podman0" ];
    };
  };
}
