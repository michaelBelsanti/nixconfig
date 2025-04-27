{
  lib,
  pkgs,
  host,
  constants,
  mylib,
  config,
  ...
}:
let
  cfg = config.networking;
in
{
  options.networking.tailscale = {
    enable = mylib.mkBool true;
    remote = mylib.mkBool false;
  };
  config.nixos = {
    environment.systemPackages = lib.mkIf (cfg.tailscale.enable && host.is "workstation") [
      pkgs.trayscale
    ];
    services.tailscale = lib.mkIf cfg.tailscale.enable {
      enable = true;
      extraSetFlags =
        [ "--operator=${constants.username}" ]
        ++ lib.optional cfg.tailscale.remote "--accept-routes"
        ++ lib.optional (!cfg.tailscale.remote) "--accept-dns=false";
    };
    networking = {
      nftables.enable = true;
      wireguard.enable = true;
      firewall.interfaces.tailscale0 = lib.mkIf cfg.tailscale.enable {
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
    systemd.services.NetworkManager-wait-online.enable = false; # nixpkgs #180175
    systemd.network.wait-online.enable = false;
  };
}
