{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.shells.ion";
  options.programs.shells.ion = with delib; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, myconfig, ... }:
    {
      environment.shells = [ pkgs.ion ];
      users.users.${myconfig.constants.username}.shell = lib.mkIf cfg.default pkgs.ion;
    };
  home.ifEnabled = {
    programs.ion = {
      enable = true;
      initExtra = "source-sh ~/.profile";
    };
  };
}
