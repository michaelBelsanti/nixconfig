{ delib, ... }:
delib.module {
  name = "programs.easyeffects";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
    services.easyeffects.enable = true;
    xdg.configFile."easyeffects" = {
      source = ./config;
      recursive = true;
    };
  };
}
