{ config, pkgs, flakePath, ... }: {
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        nixup = 
          "doas nixos-rebuild switch --flake ${flakePath} && source ~/.config/zsh/.zshrc";
        ls = "exa -al";
        lt = "exa -aT";
        cat = "bat";
        cleanup = "doas nix-collect-garbage -d";
        open = "xdg-open";
      };
      shellAbbrs = {
        lg = "lazygit";
      };
    };
  };
}