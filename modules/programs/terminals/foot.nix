{
  unify,
  pkgs,
  lib,
  ...
}:
unify.module {
  name = "programs.foot";
  options.programs.foot = with unify; {
    enable = boolOption false;
    default = boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      environment.systemPackages = [ pkgs.foot ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "footclient.desktop" ];
    };
  home.ifEnabled = {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main.font = "monospace:size=12";
        csd.size = 0;
      };
    };
  };
}
