{
  pkgs,
  lib,
  mylib,
  config,
  constants,
  ...
}:
let
  cfg = config.programs.shells.fish;
in
{
  options.programs.shells.fish = {
    enable = mylib.mkBool true;
    default = mylib.mkBool false;
  };
  config = lib.mkIf cfg.enable {
    nixos = {
      programs.fish.enable = true;
      users.users.${constants.user}.shell = lib.mkIf cfg.default pkgs.fish;
    };
    home = {
      home.packages = with pkgs.fishPlugins; [
        colored-man-pages
        done
        foreign-env
        pkgs.libnotify # notify-send for done
      ];
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting
        '';
      };
    };
  };
}
