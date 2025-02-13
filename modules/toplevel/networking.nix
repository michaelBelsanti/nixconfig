{
  delib,
  lib,
  pkgs,
  host,
  constants,
  ...
}:
delib.module {
  name = "networking";
  options.networking = {
    tailscale = {
      enable = delib.boolOption true;
      remote = delib.boolOption false;
    };
  };
  nixos.always =
    { cfg, ... }:
    {
      environment.systemPackages = lib.mkIf (cfg.tailscale.enable && host.isWorkstation) [
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
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;
    };
}
