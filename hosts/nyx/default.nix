{ delib, ... }:
delib.host {
  name = "nyx";
  type = "server";

  homeManagerSystem = "x86_64-linux";

  shared.myconfig.services.syncthing.devices.nyx.id =
    "T7ES5DM-TIODWXE-T2LME4T-3RKTD6S-WFVTSVS-QHU5WEW-Q6GDROS-46H2AQZ";
}
