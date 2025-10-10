{
  unify.modules.radicle.home =
    { pkgs, config, ... }:
    {
      home = {
        packages = with pkgs; [ radicle-node ];
        sessionVariables.RAD_HOME = "${config.xdg.configHome}/radicle";
      };
    };
}
