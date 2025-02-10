{ delib, ... }:
delib.module {
  name = "programs.topgrade";
  options = delib.singleEnableOption true;
  home.ifEnabled.programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        sudo_command = "doas";
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
