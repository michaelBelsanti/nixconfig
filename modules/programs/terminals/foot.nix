{
  delib,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.foot;
in
{
  options.programs.foot = with delib; {
    enable = mylib.mkBool false;
    default = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      environment.systemPackages = [ pkgs.foot ];
      xdg.terminal-exec.settings.default = lib.mkIf cfg.default [ "footclient.desktop" ];
    };
    home.programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main.font = "monospace:size=12";
        csd.size = 0;
      };
    };
  };
}
