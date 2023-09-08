{...}: {
  # Nushell requires more in-depth configuration
  imports = [./nushell ./fish.nix ./zsh.nix ./ion.nix];
  programs = {
    starship = {
      enable = true;
      settings = {
        format = "$all";
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](maroon)";
        };
        shell.disabled = false;
      };
    };
    carapace.enable = true;
    zoxide.enable = true;
    skim.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
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
