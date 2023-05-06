{pkgs, ...}: {
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
}
