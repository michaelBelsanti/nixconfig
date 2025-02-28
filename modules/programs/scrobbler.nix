{
  delib,
  lib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.scrobbler";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled = {
    systemd.user.services.scrobbler = {
      Unit.Description = "scrobbler background service";
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${lib.getExe pkgs.mpris-scrobbler} -v";
        Restart = "on-failure";
        Environment = "XDG_DATA_HOME=%h/.local/share";
        PassEnvironment = "PROXY";
      };
    };
  };
}
