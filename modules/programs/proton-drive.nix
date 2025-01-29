{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.proton-drive";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
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
