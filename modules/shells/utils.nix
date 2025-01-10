{ delib, ... }:
delib.module {
  name = "shells.utils";
  home.always.programs = {
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
    bat.enable = true;
    btop.enable = true;
    broot = {
      enable = true;
      settings.modal = true;
    };
    carapace.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    fzf.enable = true;
    skim.enable = true;
    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
