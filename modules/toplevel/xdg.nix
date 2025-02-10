{ delib, host, ... }:
delib.module {
  name = "xdg";
  options = delib.singleEnableOption host.isWorkstation;
  nixos.ifEnabled.xdg = {
    terminal-exec.enable = true;
    portal.xdgOpenUsePortal = true;
  };
  home.ifEnabled.xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      templates = null;
      music = null;
    };
  };
}
