{
  den.aspects.fish = {
    nixos.programs.fish.enable = true;
    homeManager =
      { pkgs, ... }:
      {
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
