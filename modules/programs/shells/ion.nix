{
  pkgs,
  lib,
  mylib,
  config,
  user,
  ...
}:
let
  cfg = config.programs.shells.ion;
in
{
  options.programs.shells.ion = {
    enable = mylib.mkBool false;
    default = mylib.mkBool false;
  };
  nixos = {
    environment.shells = [ pkgs.ion ];
    users.users.${user}.shell = lib.mkIf cfg.default pkgs.ion;
  };
  home = {
    programs.ion = {
      enable = true;
      initExtra = "source-sh ~/.profile";
    };
  };
}
