{ lib, ... }:
{
  den.aspects.filesystems.provides = {
    nixos.boot.supportedFilesystems = [ "ntfs" ];
    zfs.nixos =
      { config, pkgs, ... }:
      {
        boot.supportedFilesystems = [ "zfs" ];
        services.zfs = {
          trim.enable = true;
          autoScrub.enable = true;
        };
        services.sanoid = {
          enable = true;
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
            }) config.boot.zfs.extraPools
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
                exit 0
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
  };
}
