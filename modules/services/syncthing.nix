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
    devices = delib.attrsOfOption (delib.submodule (
      { name, ... }:
      {
        options = {
          name = delib.strOption name;
          id = delib.noDefault (delib.strOption null);
          addresses = delib.listOfOption delib.str [ "dynamic" ];
        };
      }
    )) { };
  };
  myconfig.ifEnabled.services.syncthing.devices.hypnos.id = "AOZRHZZ-JNO6DES-VPPRHK5-HW2IRRO-7XTYMQX-2J3RM4Q-C4VM6F7-RZ5LOQD";
  home.ifEnabled =
    { cfg, ... }:
    {
      home.packages = lib.mkIf (!cfg.headless) [ pkgs.syncthingtray ];
    };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      users.users.${constants.username}.extraGroups = [ "syncthing" ];
      services.syncthing =
        let
          default = {
            id = "default";
            devices = builtins.attrNames cfg.devices;
          };
        in
        lib.mkMerge [
          {
            enable = true;
            settings.devices = cfg.devices;
          }
          (lib.mkIf (!cfg.headless) {
            user = "${constants.username}";
            group = "users";
            dataDir = "${constants.home}/sync";
            configDir = "${constants.configHome}/syncthing";
            settings.folders."/home/${constants.username}/sync" = default;
          })
          (lib.mkIf (cfg.headless) {
            settings.folders."/var/lib/syncthing/sync" = default;
            guiAddress = "0.0.0.0:8384";
          })
        ];
    };
}
