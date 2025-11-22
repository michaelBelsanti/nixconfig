{
  styx.apps._.halloy.homeManager =
    { config, ... }:
    {
      sops.secrets.libera_pass = { };
      programs.halloy = {
        enable = true;
        settings = {
          font.family = "monospace";
          servers.liberachat = {
            nickname = "quasigod";
            server = "irc.libera.chat";
            nick_password_file = config.sops.secrets.libera_pass.path;
            channels = [
              "#halloy"
              "#tangled"
            ];
          };
        };
      };
    };
}
