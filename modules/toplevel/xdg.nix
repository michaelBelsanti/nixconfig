{ delib, host, ... }:
delib.module {
  name = "xdg";
  options = delib.singleEnableOption host.hasGUI;
  nixos.ifEnabled.xdg.terminal-exec.enable = true;
  home.ifEnabled = {
    xdg.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      templates = null;
      music = null;
    };
  };
}
