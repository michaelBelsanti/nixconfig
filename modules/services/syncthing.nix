{ constants, ... }:
{
  unify = {
    nixos = {
      users.users.${constants.user}.extraGroups = [ "syncthing" ];
      services.syncthing =
        let
          devices = {
            hades = {
              id = "EI3OAYC-BEJG55M-AP5OIOR-ZVDT5UE-P2GBSEY-7UJIQEQ-2IJ5CZ2-FSG6EQF";
              addresses = "dynamic";
            };
            zagreus = {
              id = "EI3OAYC-BEJG55M-AP5OIOR-ZVDT5UE-P2GBSEY-7UJIQEQ-2IJ5CZ2-FSG6EQF";
              addresses = "dynamic";
            };
            nyx = {
              id = "V3CJAAW-V5ZRINB-SIDYUZH-L6CRFTW-ZOOHA3W-KYMW5ZU-Q4IUMLS-47QSTQQ";
              addresses = "dynamic";
            };
            # hypnos = {
            #   id = "";
            #   addresses = "dynamic";
            # };
          };
          all_devices = builtins.attrNames devices;
        in
        {
          enable = true;
          openDefaultPorts = true;
          settings = {
            inherit devices;
            folders."~/sync" = {
              id = "general";
              devices = all_devices;
            };
            folders."~/projects" = {
              id = "projects";
              devices = all_devices;
            };
          };
        };
    };
    modules.workstation.nixos.services.syncthing = {
      inherit (constants) user;
      dataDir = constants.home;
    };
  };
}
