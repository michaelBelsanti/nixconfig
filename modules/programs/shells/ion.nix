{
  unify,
  pkgs,
  lib,
  constants,
  ...
}:
unify.module {
  name = "programs.shells.ion";
  options.programs.shells.ion = with unify; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.shells = [ pkgs.ion ];
      users.users.${constants.username}.shell = lib.mkIf cfg.default pkgs.ion;
    };
  home.ifEnabled = {
    programs.ion = {
      enable = true;
      initExtra = "source-sh ~/.profile";
    };
  };
}
