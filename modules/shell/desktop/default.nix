{ config, pkgs, flakePath, ...}:
{
  imports = [
    ../default.nix
  ];

  # System specific aliases
  programs.zsh = {
    initExtra = "nitch";
    shellAliases = {
      nixup = "doas nixos-rebuild switch --flake '${flakePath}#desktop' && source ~/.config/zsh/.zshrc";
      nixUp = "nix flake update ~/.flake && doas nixos-rebuild switch --flake '${flakePath}#desktop' && source ~/.config/zsh/.zshrc";
    };
  };
}