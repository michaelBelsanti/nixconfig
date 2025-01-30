{ delib, host, ...}:
delib.module {
  name = "programs.adb";
  options = delib.singleEnableOption host.isWorkstation;
  nixos.ifEnabled.programs.adb.enable = true;
}
