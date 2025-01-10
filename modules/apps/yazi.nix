{delib, ...}: delib.module {
  name = "apps.yazi";
  home.always.programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
}
