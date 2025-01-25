{
  delib,
  pkgs,
  lib,
  constants,
  ...
}:
delib.module {
  name = "shells.utils.inshellisense";
  options.shells.utils.inshellisense = with delib; {
    enable = boolOption false;
    enableBashIntegration = boolOption true;
    enableFishIntegration = boolOption true;
    enableZshIntegration = boolOption true;
    enableNushellIntegration = boolOption true;
  };
  home.ifEnabled =
    { cfg, constants, ... }:
    let
      inherit (lib) mkIf;
    in
    {
      home.packages = [ pkgs.inshellisense ];
      programs = {
        bash.initExtra = mkIf cfg.enableBashIntegration "is init bash";
        fish.interactiveShellInit = mkIf cfg.enableFishIntegration "is init fish";
        zsh.initExtra = mkIf cfg.enableZshIntegration "is init zsh";
        nushell.extraEnv = mkIf cfg.enableNushellIntegration "is init nu";
      };
    };
}
