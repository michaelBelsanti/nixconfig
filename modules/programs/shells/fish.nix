{
  delib,
  pkgs,
  lib,
  ...
}:
delib.module {
  name = "programs.shells.fish";
  options = with delib; {
    enable = enableOption true;
    default = enableOption true;
  };
  nixos.ifEnabled =
    { cfg, myconfig, ... }:
    {
      programs.fish.enable = true;
      users.users.${myconfig.constants.username}.shell = cfg.default;
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
      shellAliases = {
        open = "xdg-open";
        mkdir = "mkdir -p";
        cd = "z";
      };
      shellAbbrs = {
        lg = "lazygit";
      };
      interactiveShellInit = ''
        set fish_greeting
        ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      '';
    };
  };
}
