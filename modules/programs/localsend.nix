{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.localsend";
  options = delib.singleEnableOption host.isWorkstation;
  nixos.ifEnabled.programs.localsend.enable = true;
  home.ifEnabled.home.packages = [ pkgs.localsend ];
}
