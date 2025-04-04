{ unify, host, ... }:
unify.module {
  name = "programs.adb";
  options = unify.singleEnableOption host.isWorkstation;
  nixos.ifEnabled.programs.adb.enable = true;
}
