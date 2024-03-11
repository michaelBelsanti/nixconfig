{ config, pkgs, lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.apps.spicetify;
in
{
  options.apps.spicetify.enable = mkBoolOpt false "Enable Spicetify";
  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with pkgs.spicePkgs.extensions; [
        fullAppDisplay
        featureShuffle
        hidePodcasts
      ];
    };
  };
}
