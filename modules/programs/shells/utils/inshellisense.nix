{
  pkgs,
  lib,
  mylib,
  config,
  ...
}:
let
  cfg = config.shells.utils.inshellisense;
in
{
  options.shells.utils.inshellisense = {
    enable = mylib.mkBool false;
    enableBashIntegration = mylib.mkBool true;
    enableFishIntegration = mylib.mkBool true;
    enableZshIntegration = mylib.mkBool true;
    enableNushellIntegration = mylib.mkBool true;
  };
  config.home = lib.mkIf cfg.enable {
    home.packages = [ pkgs.inshellisense ];
    programs = {
      bash.initExtra = lib.mkIf cfg.enableBashIntegration "is init bash";
      fish.interactiveShellInit = lib.mkIf cfg.enableFishIntegration "is init fish";
      zsh.initExtra = lib.mkIf cfg.enableZshIntegration "is init zsh";
      nushell.extraEnv = lib.mkIf cfg.enableNushellIntegration "is init nu";
    };
  };
}
