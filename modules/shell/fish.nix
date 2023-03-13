{ config, pkgs, flakePath, ... }:
  let fishPlugins = pkgs.fishPlugins; in
{ 
  home.packages = with pkgs; [ libnotify ]; # For `done` plugin
  programs. fish = {
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
    plugins = [
      { name = "pure"; src = fishPlugins.pure.src; }
      { name = "done"; src = fishPlugins.done.src; }
      { name = "sponge"; src = fishPlugins.sponge.src; }
      { name = "pisces"; src = fishPlugins.pisces.src; }
      { name = "fzf-fish"; src = fishPlugins.fzf-fish.src; }
      { name = "colored-man-pages"; src = fishPlugins.colored-man-pages.src; }
    ];
  };
}