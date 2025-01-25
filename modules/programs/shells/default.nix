{
  delib,
  pkgs,
  constants,
  ...
}:
delib.module {
  name = "programs.shells";
  nixos.always.environment.shells = [ pkgs.bash ];
  home.always =

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
        historyFile = "${constants.dataHome}/bash/history";
      };
    };
}
