{
  delib,
  host,
  constants,
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
  myconfig.ifEnabled.services.syncthing.devices.shit_phone.id =
    "2M5G4SD-LSEKDXK-5KB3EYF-CXIFVKY-3YSM35Y-KJTWQH2-ATNGIF4-RUBDTQ7";
  nixos.ifEnabled =
    { cfg, ... }:
    {
      users.users.${constants.username}.extraGroups = [ "syncthing" ];
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
            user = constants.username;
            dataDir = constants.home;
          })
          (lib.mkIf cfg.headless {
            dataDir = "/var/lib/syncthing";
            guiAddress = "0.0.0.0:8384";
          })
        ];
    };
}
