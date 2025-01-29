{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.easyeffects";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
    services.easyeffects.enable = true;
    xdg.configFile."easyeffects" = {
      source = ./config;
      recursive = true;
    };
    home.packages = with pkgs; [
      (writeShellScriptBin "eerestart" ''
        pkill easyeffects
        sleep .5
        easyeffects --gapplication-service &
      '')
    ];
  };
}
