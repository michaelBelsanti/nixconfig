{ lib, sources, ... }:
{
  unify.modules.workstation = {
    home =
      { pkgs, ... }:
      let
        mpris-scrobbler = pkgs.mpris-scrobbler.overrideAttrs {
          inherit (sources.mpris-scrobbler) src;
        };
      in
      {
        home.packages = [ mpris-scrobbler ];
        systemd.user.services.scrobbler = {
          Unit.Description = "scrobbler background service";
          Install.WantedBy = [ "graphical-session.target" ];
          Service = {
            ExecStart = "${lib.getExe mpris-scrobbler} -v";
            Restart = "on-failure";
            Environment = "XDG_DATA_HOME=%h/.local/share";
            PassEnvironment = "PROXY";
          };
        };
      };
  };
}
