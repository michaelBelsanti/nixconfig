{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.spicetify;
in
{
  options.apps.spicetify.enable = mkBoolOpt false "Enable Spicetify";
  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with pkgs.spicePkgs.extensions; [
        playlistIcons
        lastfm
        historyShortcut
        hidePodcasts
        fullAppDisplay
        shuffle
      ];
    };
  };
}
