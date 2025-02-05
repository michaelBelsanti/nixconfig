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
        ];
        cleanup = true;
      };
      pre_commands."System upgrade" = "nh os switch -u";
    };
  };
}
