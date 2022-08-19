{ config, pkgs, ...}:
{
  programs.zsh.shellAliases = {
    nixup = "doas nixos-rebuild switch --flake '/home/quasi/.flake/#laptop' && source ~/.config/zsh/.zshrc";
    nixUp = "nix flake update ~/.flake && doas nixos-rebuild switch --flake '/home/quasi/.flake/#laptop' && source ~/.config/zsh/.zshrc";
  };
 }