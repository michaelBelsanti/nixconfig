{
  unify.home =
    { pkgs, config, ... }:
    {
      home.shellAliases = {
        cd = "z";
        lj = "lazyjj";
        lg = "lazygit";
        o = "xdg-open";
        mkdir = "mkdir -p";
        tree = "eza -T";
      };
      programs = {
        bash = {
          enable = true;
          enableVteIntegration = true;
          historyFile = "${config.xdg.configHome}/bash/history";
        };
        starship = {
          enable = true;
          package = pkgs.starship.overrideAttrs {
            patches = pkgs.fetchurl {
              url = "https://patch-diff.githubusercontent.com/raw/starship/starship/pull/6089.patch";
              hash = "sha256-6hSVUvVRr8UHHrfgzn/JOooELxz8xvZQwyQY5KJLvPU=";
            };
          };
          settings = {
            format = "$all";
            character = {
              success_symbol = "[➜](bold green)";
              error_symbol = "[➜](maroon)";
            };
            shell.disabled = false;
            # For jujutsu
            git_branch.disabled = true;
            git_commit.disabled = true;
            git_state.disabled = true;
            git_metrics.disabled = true;
            git_status.disabled = true;
          };
        };
        atuin = {
          enable = true;
          flags = [ "--disable-up-arrow" ];
        };
        bat = {
          enable = true;
          config.style = "plain";
          extraPackages = with pkgs.bat-extras; [
            prettybat
            batwatch
            batpipe
            batman
            batgrep
            batdiff
          ];
        };
        bottom.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        eza = {
          enable = true;
          git = true;
          icons = "auto";
          enableNushellIntegration = false;
        };
        nix-your-shell.enable = true;
        skim.enable = true;
        tealdeer = {
          enable = true;
          settings.updates.auto_update = true;
        };
        yazi.enable = true;
        zoxide.enable = true;
      };
    };
}
