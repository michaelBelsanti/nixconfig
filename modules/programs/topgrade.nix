{ unify, lib, ... }:
unify.module {
  name = "programs.topgrade";
  options = unify.singleEnableOption true;
  home.ifEnabled =
    { myconfig, ... }:
    {
      programs.topgrade = {
        enable = true;
        settings = {
          misc = {
            assume_yes = true;
            sudo_command = lib.mkIf myconfig.security.doas.enable "doas";
            disable = [
              "system"
              "helix"
              "uv"
              "bun"
              "github_cli_extensions"
            ];
            cleanup = true;
          };
        };
      };
    };
}
