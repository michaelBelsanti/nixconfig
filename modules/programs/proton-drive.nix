{
  lib,
  pkgs,
  mylib,
  config,
  ...
}:
{
  options.programs.proton-drive.enable = mylib.mkBool false;
  config.home = lib.mkIf config.options.programs.proton-drive.enable {
    systemd.user.services.proton-drive = {
      Unit = {
        Description = "proton-drive background service";
        After = [ "network-online.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStartPre = "/usr/bin/env mkdir -p %h/Proton";
        ExecStart = "${lib.getExe pkgs.rclone} mount --vfs-cache-mode full proton: %h/Proton";
        ExecStop = "/bin/fusermount -u %h/Proton";
      };
    };
  };
}
