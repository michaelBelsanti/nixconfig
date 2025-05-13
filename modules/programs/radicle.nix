{ constants, ... }:
{
  unify = {
    home =
      { pkgs, ... }:
      {
        home = {
          shellAliases.jji = "jj --ignore-immutable";
          packages = with pkgs; [ radicle-node ];
          sessionVariables.RAD_HOME = "${constants.configHome}/radicle";
        };
      };
  };
}
