{
  delib,
  lib,
  pkgs,
  host,
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
      systemd = {
        services."zpool-check" = {
          path = with pkgs; [
            curl
            zfs
            choose
          ];
          script = ''
            ${pkgs.writeScript "zpool-check-script" ''
              #!${lib.getExe pkgs.nushell}
              let status = zpool status -x | complete
              if ($status.stdout | str trim) == "all pools are healthy" {
                print $"($status.stdout)"
              } else {
                print $"($status.stdout)"
                curl -d $"($status.stdout)" ntfy.sh/streamquasimedia
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
