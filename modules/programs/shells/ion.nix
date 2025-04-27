{
  pkgs,
  lib,
  mylib,
  config,
  constants,
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
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.shells = [ pkgs.ion ];
      users.users.${constants.user}.shell = lib.mkIf cfg.default pkgs.ion;
    };
    home = {
      programs.ion = {
        enable = true;
        initExtra = "source-sh ~/.profile";
      };
    };
  };
}
