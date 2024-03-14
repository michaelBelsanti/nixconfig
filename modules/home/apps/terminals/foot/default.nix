{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.foot;
in
{
  options.apps.foot.enable = mkBoolOpt false "Enable foot configuration.";
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main.font = "monospace:size=12";
        csd.size = 0;
      };
    };
  };
}
