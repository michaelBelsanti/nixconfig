{ delib, host, ... }:
delib.module {
  name = "programs.easyeffects";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled = {
    services.easyeffects.enable = true;
    xdg.configFile."easyeffects" = {
      source = ./config;
      recursive = true;
    };
  };
}
