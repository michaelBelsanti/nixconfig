{ delib, pkgs, ... }:
delib.module {
  name = "shells.bash";
  nixos.always.environment.shells = [ pkgs.bash ];
  home.always =
    { myconfig, ... }:
    {
      programs.bash = {
        enable = true;
        enableVteIntegration = true;
        # historyFileSize = 0;
        historyFile = "${myconfig.constants.dataHome}/bash/history";
      };
    };
}
