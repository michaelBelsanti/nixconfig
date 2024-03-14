{ lib, config, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  cfg = config.theming;
  isCatppuccin = cfg.theme == "catppuccin";
  isRosePine = cfg.theme == "rose-pine";
in
{
  options = {
    theming = {
      enable = mkEnableOption "theming";
      theme = mkOption {
        default = "catppuccin";
        type = types.enum [
          "catppuccin"
          "rosepine"
        ];
        example = "rose_pine";
        description = lib.mdDoc ''
          Selects the theme for all apps themed using home-manager.
        '';
      };
      variant = mkOption {
        default = if isCatppuccin then "macchiato" else "";
        type =
          if isCatppuccin then
            types.enum [
              "latte"
              "frappe"
              "macchiato"
              "mocha"
            ]
          else if isRosePine then
            types.enum [
              "dawn"
              "moon"
            ]
          else
            types.enum [ "" ];
      };
      accent = mkOption {
        default = if isCatppuccin then "mauve" else "";
        type =
          if isCatppuccin then
            types.enum [
              "rosewater"
              "flamingo"
              "pink"
              "mauve"
              "red"
              "maroon"
              "peach"
              "yellow"
              "green"
              "teal"
              "sky"
              "sapphire"
              "blue"
              "lavender"
            ]
          else
            types.enum [ "" ];
      };
    };
  };
}
