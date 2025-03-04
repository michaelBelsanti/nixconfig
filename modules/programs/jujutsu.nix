{ delib, ... }:
delib.module {
  name = "programs.jujutsu";
  options = delib.singleEnableOption true;
  home.ifEnabled = {
    home.shellAliases.jji = "jj --ignore-immutable";
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "quasigod";
          email = "quasigod-io@proton.me";
        };
        ui = {
          paginate = "never";
          default-command = "log";
        };
      };
    };
  };
}
