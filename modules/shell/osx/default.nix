{ ... }: {
  imports = [ ../default.nix ];

  # System specific aliases
  programs.zsh.shellAliases = {
    nixup =
      "pushd ~/.flake && ./result/sw/bin/darwin-rebuild switch --flake '.#osx' && source ~/.config/zsh/.zshrc && popd";
    nixUp =
      "pushd ~/.flake && nix flake update && nix build '.#darwinConfigurations.osx.system' && ./result/sw/bin/darwin-rebuild switch --flake '.#osx' && source ~/.config/zsh/.zshrc";
  };
}
