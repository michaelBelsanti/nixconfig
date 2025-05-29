{
  unify =
    let
      devices = {
        hades.id = "EI3OAYC-BEJG55M-AP5OIOR-ZVDT5UE-P2GBSEY-7UJIQEQ-2IJ5CZ2-FSG6EQF";
        zagreus.id = "V3CJAAW-V5ZRINB-SIDYUZH-L6CRFTW-ZOOHA3W-KYMW5ZU-Q4IUMLS-47QSTQQ";
        nyx.id = "T7ES5DM-TIODWXE-T2LME4T-3RKTD6S-WFVTSVS-QHU5WEW-Q6GDROS-46H2AQZ";
      };
      all_devices = builtins.attrNames devices;
      syncthing = {
        enable = true;
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
    in
    {
      modules.syncthing-client.home.services = {
        inherit syncthing;
      };
      modules.syncthing-server.nixos.services.syncthing = syncthing // {
        openDefaultPorts = true;
      };
    };
}
