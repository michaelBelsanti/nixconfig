{
  delib,
  lib,
  pkgs,
  host,
  config,
  ...
}:
delib.module {
  name = "zfs";
  options.zfs = with delib; {
    enable = boolOption host.isServer;
    pools = listOfOption str [ ];
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      boot = {
        supportedFilesystems = [ "zfs" ];
        zfs.extraPools = cfg.pools;
      };
      services.zfs = {
        trim.enable = true;
        autoScrub.enable = true;
      };
      sops.secrets.ntfy_creds = { };
      sops.secrets.ntfy_url = { };
      systemd = {
        services."zpool-check" = {
          path = with pkgs; [
            curl
            zfs
            choose
            ntfy-sh
          ];
          script = ''
            ${pkgs.writeScript "zpool-check-script" ''
              #!${lib.getExe pkgs.nushell}
              let status = zpool status -x
              if ($status | str trim) == "all pools are healthy" {
                print $"($status)"
              } else {
                print $"($status)"
                (ntfy publish 
                  -u $"(cat ${config.sops.secrets.ntfy_creds.path}) 
                  $"(cat ${config.sops.secrets.ntfy_url.path})
                  $status)
              }
            ''}
          '';
        };
        timers."zpool-check" = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnBootSec = "1h";
            OnUnitActiveSec = "1h";
            Unit = "zpool-check.service";
          };
        };
      };
    };
}
