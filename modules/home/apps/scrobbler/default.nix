{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.scrobbler;
in
{
  options.apps.scrobbler.enable = mkBoolOpt false "Enable mpris-scrobbler as a service.";
  config = mkIf cfg.enable {
    systemd.user.services.mpris-scrobbler = {
      Unit.Description = "mpris-scrobbler background service";
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${lib.getExe pkgs.mpris-scrobbler}";
        Restart = "on-failure";
      };
    };
  };
}
