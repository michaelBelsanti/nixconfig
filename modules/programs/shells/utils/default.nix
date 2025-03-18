{
  delib,
  host,
  lib,
  pkgs,
  config,
  compat,
  ...
}:
delib.module {
  name = "programs.shells.utils";
  home.always.programs =
    let
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    in
    {
      starship = {
        enable = true;
        package = pkgs.starship.overrideAttrs {
          patches = pkgs.fetchurl {
            url = "https://patch-diff.githubusercontent.com/raw/starship/starship/pull/6089.patch";
            hash = "sha256-6hSVUvVRr8UHHrfgzn/JOooELxz8xvZQwyQY5KJLvPU=";
          };
        };
        settings =
          {
            format = "$all";
            character = {
              success_symbol = "[➜](bold green)";
              error_symbol = "[➜](maroon)";
            };
            shell.disabled = false;
            # for showing name when using something like sshmux
            hostname.ssh_only = !host.isServer;
          }
          // lib.optionalAttrs config.myconfig.programs.jujutsu.enable {
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
        inherit enableFishIntegration enableNushellIntegration;
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
      };
      skim.enable = true;
      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
      };
      yazi = {
        enable = true;
        inherit
          enableBashIntegration
          enableFishIntegration
          enableZshIntegration
          enableNushellIntegration
          ;
      };
      zoxide.enable = true;
    } // compat.mkCompat {
      nix-your-shell = {
        enable = true;
        inherit enableFishIntegration enableNushellIntegration enableZshIntegration;
      };
    } {};
}
