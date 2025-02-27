{
  delib,
  host,
  lib,
  pkgs,
  config,
  ...
}:
delib.module {
  name = "programs.shells.utils";
  home.always.programs = {
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
          hostname.ssh_only = lib.mkIf host.isServer true;
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
      enableFishIntegration = true;
      enableNushellIntegration = true;
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
    };
    skim.enable = true;
    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    zoxide.enable = true;
  };
}
