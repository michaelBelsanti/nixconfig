{ pkgs, flakePath, ... }:
{ 
  home.packages = with pkgs.fishPlugins; [ 
    done
    pkgs.libnotify # notify-send for done
    sponge
    pisces
    fzf-fish
    colored-man-pages
  ];
  programs.fish = {
    enable = true;
    shellAliases = {
      nixup = 
        "doas nixos-rebuild switch --flake ${flakePath} && source ~/.config/fish/config.fish";
      cleanup = "doas nix-collect-garbage -d";
      open = "xdg-open";
    };
    shellAbbrs = {
      lg = "lazygit";
    };
    interactiveShellInit = ''
      set fish_greeting
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      eval (zellij setup --generate-auto-start fish | string collect)
    '';
  };
}