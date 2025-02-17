{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.jujutsu";
  options = delib.singleEnableOption true;
  home.ifEnabled.programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "quasigod";
        email = "quasigod-io@proton.me";
      };
    };
  };
}
