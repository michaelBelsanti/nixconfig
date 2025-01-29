{ delib, ... }:
delib.module {
  name = "networking";
  nixos.always = {
    networking.wireguard.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
  };
}
