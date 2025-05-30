{
  unify.modules.workstation.home =
    { pkgs, lib, ... }:
    {
      systemd.user.services.snapcast-client = {
        Install.WantedBy = [ "graphical-session.target" ];
        Service.ExecStart = "${lib.getExe' pkgs.snapcast "snapclient"} --player pulse";
      };
    };
}
