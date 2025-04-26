{
  pkgs,
  lib,
  mylib,
  config,
  ...
}:
{
  options.programs.scrobbler.enable = mylib.mkEnabledIf "workstation";
  config.home =
    let
      mpris-scrobbler = pkgs.mpris-scrobbler.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "mariusor";
          repo = "mpris-scrobbler";
          rev = "da3442b7815264b1845b83b05c56bf1d3af5c324";
          hash = "sha256-ZIRkcIKQVOYkj4Bus30E1jdLZc5kTanS6U+UZYAJXag=";
        };
      };
    in
    lib.mkIf config.programs.scrobbler.enable {
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
}
