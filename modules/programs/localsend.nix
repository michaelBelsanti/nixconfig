{
  unify,
  host,
  pkgs,
  ...
}:
unify.module {
  name = "programs.localsend";
  options = unify.singleEnableOption host.isWorkstation;
  nixos.ifEnabled.programs.localsend.enable = true;
  home.ifEnabled.home.packages = [ pkgs.localsend ];
}
