{
  pkgs,
  mylib,
  config,
  lib,
  ...
}:
{
  options.programs.localsend.enable = mylib.mkEnabledIf "workstation";
  config = lib.mkIf config.programs.localsend.enable {
    nixos.programs.localsend.enable = true;
    home.home.packages = [ pkgs.localsend ];
  };
}
