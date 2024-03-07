{ pkgs, ... }:
{
  programs.spicetify = {
    enable = true;
    enabledExtensions = with pkgs.spicePkgs.extensions; [
      fullAppDisplay
      featureShuffle
      hidePodcasts
    ];
  };
}
