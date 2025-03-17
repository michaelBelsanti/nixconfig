{
  delib,
  pkgs,
  lib,
  constants,
  ...
}:
delib.module {
  name = "programs.shells.fish";
  options.programs.shells.fish = with delib; {
    enable = boolOption true;
    default = boolOption true;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
      programs.fish.enable = true;
      users.users.${constants.username}.shell = lib.mkIf cfg.default pkgs.fish;
    };
  home.ifEnabled = {
    home.packages = with pkgs.fishPlugins; [
      colored-man-pages
      done
      foreign-env
      # fzf-fish
      # pisces
      # sponge
      pkgs.libnotify # notify-send for done
    ];
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };
}
