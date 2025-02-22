{
  delib,
  pkgs,
  constants,
  ...
}:
delib.module {
  name = "programs.shells";
  nixos.always.environment.shells = [ pkgs.bashInteractive ];
  home.always = {
    home.shellAliases = {
      cd = "z";
      lj = "lazyjj";
      lg = "lazygit";
      open = "xdg-open";
      mkdir = "mkdir -p";
      tree = "eza -T";
      get = "aria2c";
    };
    programs.bash = {
      enable = true;
      enableVteIntegration = true;
      historyFile = "${constants.dataHome}/bash/history";
    };
  };
}
