{ config, flakePath, ... }: {
  imports = [ ../default.nix ];

  # System specific aliases
  programs.zsh = {
    initExtra = "nitch";
    shellAliases = {
      nixup =
        "doas nixos-rebuild switch --flake '${flakePath}#nix-laptop' && source ~/.config/zsh/.zshrc";
      nixUp =
        "nix flake update ${flakePath} && doas nixos-rebuild switch --flake '${flakePath}#nix-laptop' && source ~/.config/zsh/.zshrc";
    };
  };
}
