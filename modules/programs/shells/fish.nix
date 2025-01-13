{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.shells.fish";
  options.programs.shells.fish = with delib; {
    enable = boolOption true;
    default = boolOption true;
  };
  nixos.ifEnabled =
    { cfg, myconfig, ... }:
    {
      programs.fish.enable = true;
      users.users.${myconfig.constants.username}.shell = lib.mkIf cfg.default pkgs.fish;
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
        ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      '';
    };
  };
}
