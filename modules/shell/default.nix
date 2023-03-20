{ config, pkgs, flakePath, ... }: {
  # Nushell requires more in-depth configuration
  imports = [ ./nushell ./fish.nix ./zsh.nix ./ion.nix];
  programs = {
    starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    bash = {
      enable = true;
      enableVteIntegration = true;
      historyFileSize = 0;
    };
  };
}
