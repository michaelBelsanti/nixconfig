{
  mylib,
  lib,
  pkgs,
  host,
  config,
  ...
}:
let
  cfg = config.zfs;
in
{
  name = "zfs";
  options.zfs = {
    enable = mylib.mkEnabledIf host.is "server";
    pools = mylib.mkOption (lib.types.listOf lib.types.str) [ ];
    sanoid = mylib.mkBool cfg.enable;
  };
  config.nixos = lib.mkIf cfg.enable {
    boot = {
      supportedFilesystems = [ "zfs" ];
      zfs.extraPools = cfg.pools;
    };
    services.zfs = {
      trim.enable = true;
      autoScrub.enable = true;
    };
    services.sanoid = {
      enable = cfg.sanoid;
      templates.main = {
        daily = 30;
        hourly = 24;
      };
      datasets = builtins.listToAttrs (
        map (pool: {
          name = pool;
          value = {
            useTemplate = [ "main" ];
          };
        }) cfg.pools
      );
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
