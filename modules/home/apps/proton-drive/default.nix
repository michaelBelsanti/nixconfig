{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.proton-drive;
in
{
  options.apps.proton-drive.enable = mkBoolOpt false "Enable mpris-proton-drive as a service.";
  config = mkIf cfg.enable {
    systemd.user.services.proton-drive = {
      Unit = {
        Description = "proton-drive background service";
        After = [ "network-online.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStartPre = "/usr/bin/env mkdir -p %h/Proton";
        ExecStart = "${lib.getExe pkgs.rclone} mount --vfs-cache-mode full proton: %h/Proton";
        ExecStop="/bin/fusermount -u %h/Proton";
      };
    };
  };
}
