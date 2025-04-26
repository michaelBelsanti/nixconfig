{
  lib,
  mylib,
  config,
  ...
}:
{
  options.programs.topgrade = mylib.mkBool true;
  config.home.programs.topgrade = lib.mkIf config.programs.topgrade {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        sudo_command = lib.mkIf config.security.doas.enable "doas";
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
}
