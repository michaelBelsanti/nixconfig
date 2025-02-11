{
  delib,
  host,
  constants,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "services.syncthing";
  options.services.syncthing = {
    enable = delib.boolOption true;
    headless = delib.boolOption host.isServer;
  };
  home.ifEnabled =
    { cfg, ... }:
    {
      home.packages = lib.mkIf (!cfg.headless) [ pkgs.syncthingtray ];
    };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      users.users.${constants.username}.extraGroups = [ "syncthing" ];
      services.syncthing = lib.mkMerge [
        { enable = true; }
        (lib.mkIf (!cfg.headless) {
          user = "${constants.username}";
          group = "users";
          dataDir = "${constants.home}/sync";
          configDir = "${constants.configHome}/syncthing";
          settings.folders."/home/${constants.username}/sync".id = "default";
        })
        (lib.mkIf (cfg.headless) {
          settings.folders."/var/lib/syncthing/sync".id = "default";
          guiAddress = "0.0.0.0:8384";
        })
      ];
    };
}
