{ config, pkgs, flakePath, ... }: {
  # Nushell requires more in-depth configuration
  imports = [ ./nushell ./fish.nix ./zsh.nix ./ion.nix];
  programs = {
    starship = {
      enable = true;
      enableIonIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    zoxide.enable = true;
    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    bash = {
      enable = true;
      enableVteIntegration = true;
      historyFileSize = 0;
    };
  };
}
