{
  unify = {
    nixos =
      { pkgs, ... }:
      {
        environment.shells = [ pkgs.bashInteractive ];
      };
    home =
      { config, ... }:
      {
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
          historyFile = "${config.xdg.configHome}/bash/history";
        };
      };
  };
}
