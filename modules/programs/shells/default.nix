{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.shells";
  nixos.always.environment.shells = [ pkgs.bash ];
  home.always =
    { myconfig, ... }:
    {
      home.shellAliases = {
        cd = "z";
        lg = "lazygit";
        open = "xdg-open";
        mkdir = "mkdir -p";
        tree = "eza -T";
      };
      programs.bash = {
        enable = true;
        enableVteIntegration = true;
        # historyFileSize = 0;
        historyFile = "${myconfig.constants.dataHome}/bash/history";
      };
    };
}
