{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.rio;
in
{
  options.apps.rio.enable = mkBoolOpt false "Enable rio configuration.";
  config = mkIf cfg.enable {
    programs.rio = {
      enable = true;
      settings = {
        window.decorations = "Disabled";
        fonts = {
          size = 18;
        };
        keyboard.use-kitty-keyboard-protocol = true;
      };
    };
  };
}
