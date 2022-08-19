{ config, pkgs, ...}:
{
  programs.zsh.shellAliases = {
    nixup = "doas nixos-rebuild switch --flake '/home/quasi/.flake/#desktop' && source ~/.config/zsh/.zshrc";
    nixUp = "nix flake update ~/.flake && doas nixos-rebuild switch --flake '/home/quasi/.flake/#desktop' && source ~/.config/zsh/.zshrc";
  };
}