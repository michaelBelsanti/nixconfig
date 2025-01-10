{ delib, ... }:
delib.module {
  name = "apps.terminals.foot";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main.font = "monospace:size=12";
        csd.size = 0;
      };
    };
  };
}
