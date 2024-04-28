{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.kitty;
in
{
  options.apps.kitty.enable = mkBoolOpt false "Enable kitty configuration.";
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "monospace";
        size = 12;
      };
      settings = {
        clear_all_shortcuts = true;
        enable_audio_bell = false;
        update_check_interval = 0;
      };
    };
  };
}
