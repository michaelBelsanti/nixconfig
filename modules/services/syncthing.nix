{
  host,
  constants,
  lib,
  mylib,
  config,
  ...
}:
let
  cfg = config.services.syncthing;
in
{
  options.services.syncthing = {
    enable = mylib.boolOption true;
    headless = mylib.mkEnabledIf host.is "server";
    devices = mylib.mkOption (lib.types.submodule (
      { name, ... }:
      {
        options = {
          name = mylib.mkOption lib.types.str name;
          id = mylib.mkOption lib.types.str null;
          addresses = mylib.mkOption (lib.types.listOf lib.types.str) [ "dynamic" ];
        };
      }
    )) { };
  };
  config.nixos = lib.mkIf cfg.enable {
    users.users.${constants.user}.extraGroups = [ "syncthing" ];
    services.syncthing =
      let
        all_devices = builtins.attrNames cfg.devices;
      in
      lib.mkMerge [
        {
          enable = true;
          openDefaultPorts = true;
          settings = {
            inherit (cfg) devices;
            folders."~/sync" = {
              id = "general";
              devices = all_devices;
            };
            folders."~/projects" = {
              id = "projects";
              devices = all_devices;
            };
          };
        }
        (lib.mkIf (!cfg.headless) {
          inherit (constants) user;
          dataDir = constants.home;
        })
        (lib.mkIf cfg.headless {
          dataDir = "/var/lib/syncthing";
          guiAddress = "0.0.0.0:8384";
        })
      ];
  };
}
