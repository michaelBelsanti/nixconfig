{ lib, ... }:
{
  styx.syncthing =
    let
      devices = {
        hades.id = "EI3OAYC-BEJG55M-AP5OIOR-ZVDT5UE-P2GBSEY-7UJIQEQ-2IJ5CZ2-FSG6EQF";
        zagreus.id = "V3CJAAW-V5ZRINB-SIDYUZH-L6CRFTW-ZOOHA3W-KYMW5ZU-Q4IUMLS-47QSTQQ";
        nyx.id = "T7ES5DM-TIODWXE-T2LME4T-3RKTD6S-WFVTSVS-QHU5WEW-Q6GDROS-46H2AQZ";
        hypnos.id = "3BIHHZK-YAEPGPG-ZKZ6NQX-TSUAIK4-F4RFBZ6-YTYMOZ7-P366YJU-BDISVQ7";
      };
      all_devices = builtins.attrNames devices;
      syncthing = {
        enable = true;
        settings = {
          inherit devices;
          folders = {
            "~/projects" = {
              id = "projects";
              devices = [
                "hades"
                "zagreus"
                "nyx"
              ];
            };
            "~/Documents" = {
              id = "documents";
              devices = [
                "hades"
                "zagreus"
                "nyx"
              ];
            };
            "~/elysium" = {
              id = "elysium";
              devices = all_devices;
            };
          };
        };
      };
    in
    {
      provides.client.homeManager.services = {
        inherit syncthing;
      };
      provides.server.nixos.services.syncthing = lib.mkMerge [
        syncthing
        {
          openDefaultPorts = true;
          devices = lib.mapAttrs (name: value: value // { autoAcceptFolders = true; }) devices;
        }
      ];
    };
}
