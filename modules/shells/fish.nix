{ delib, pkgs, ... }:
delib.module {
  name = "shells.fish";
  options = delib.singleEnableOption false;
  nixos.ifEnabled.programs.fish.enable = true;
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
