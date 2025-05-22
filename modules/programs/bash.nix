{ constants, ... }:
{
  unify = {
    nixos =
      { pkgs, ... }:
      {
        environment.shells = [ pkgs.bashInteractive ];
      };
    home = {
      home.shellAliases = {
        cd = "z";
        lj = "lazyjj";
        lg = "lazygit";
        o = "xdg-open";
        mkdir = "mkdir -p";
        tree = "eza -T";
      };
      programs.bash = {
        enable = true;
        enableVteIntegration = true;
        historyFile = "${constants.configHome}/bash/history";
      };
    };
  };
}
