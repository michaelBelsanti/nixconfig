{
  styx.networking = {
    provides.static.nixos.networking.tempAddresses = "disabled";
    provides.wired.nixos = {
      networking.networkmanager.unmanaged = [ "lan" ];
      systemd.network = {
        enable = true;
        links."10-ethernet" = {
          matchConfig.Type = "ether";
          linkConfig.WakeOnLan = "magic";
          linkConfig.Name = "lan";
        };
        networks."10-ethernet" = {
          matchConfig.Type = "ether";
          networkConfig.DHCP = "yes";
        };
      };
    };
    nixos.networking = {
      nftables.enable = true;
      wireguard.enable = true;
      firewall.trustedInterfaces = [ "podman0" ];
    };
  };
}
