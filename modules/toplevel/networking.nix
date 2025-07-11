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
        systemd.services.tailscaled.serviceConfig = {
          DeviceAllow = [
            "/dev/tun"
            "/dev/net/tun"
          ];
          AmbientCapabilities = "CAP_NET_RAW CAP_NET_ADMIN CAP_SYS_MODULE";
          ProtectKernelModules = "no";
          RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
          NoNewPrivileges = "yes";
          PrivateTmp = "yes";
          PrivateMounts = "yes";
          RestrictNamespaces = "yes";
          RestrictRealtime = "yes";
          RestrictSUIDSGID = "yes";
          MemoryDenyWriteExecute = "yes";
          LockPersonality = "yes";
          ProtectHome = "yes";
          ProtectControlGroups = "yes";
          ProtectKernelLogs = "yes";
          ProtectSystem = "full";
          ProtectProc = "noaccess";
          SystemCallArchitectures = "native";
          SystemCallFilter = [
            "@known"
            "~@clock @cpu-emulation @raw-io @reboot @mount @obsolete @swap @debug @keyring @mount @pkey"
          ];
        };
      };
  };
}
