{
  delib,
  host,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.shells.utils";
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
        # for showing name when using something like sshmux
        hostname.ssh_only = lib.mkIf host.isServer true;
      };
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
