{
  unify.home =
    { pkgs, config, ... }:
    {
      home = {
        shellAliases.jji = "jj --ignore-immutable";
        packages = with pkgs; [ radicle-node ];
        sessionVariables.RAD_HOME = "${config.xdg.configHome}/radicle";
      };
    };
}
