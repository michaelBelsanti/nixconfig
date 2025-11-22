{
  styx.apps._.radicle.homeManager =
    { pkgs, config, ... }:
    {
      home = {
        packages = with pkgs; [ radicle-node ];
        sessionVariables.RAD_HOME = "${config.xdg.configHome}/radicle";
      };
    };
}
