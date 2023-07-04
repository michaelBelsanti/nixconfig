{
  pkgs,
  flakePath,
  ...
}: {
  home.packages = with pkgs.fishPlugins; [
    colored-man-pages
    done
    foreign-env
    fzf-fish
    # pisces
    sponge
    pkgs.libnotify # notify-send for done
  ];
  programs.fish = {
    enable = true;
    shellAliases = {
      nixup = "doas nixos-rebuild switch --flake ${flakePath} && source ~/.config/fish/config.fish";
      cleanup = "doas nix-collect-garbage -d";
      open = "xdg-open";
      mkdir = "mkdir -p";
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
