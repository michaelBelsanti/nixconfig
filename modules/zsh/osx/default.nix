{ config, pkgs, ...}:
{
  imports = [
    ../default.nix
  ];
  
  # System specific aliases
  programs.zsh.shellAliases = {
    nixup = "pushd ~/.flake && ./result/sw/bin/darwin-rebuild switch --flake '.#osx' && source ~/.config/zsh/.zshrc && popd";
    nixUp = "pushd ~/.flake && nix --extra-experimental-features nix-command build --extra-experimental-features flakes '.#darwinConfigurations.osx.system' && ./result/sw/bin/darwin-rebuild switch --flake '.#osx' && source ~/.config/zsh/.zshrc";
  };
 }