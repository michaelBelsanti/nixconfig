{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.theming;
  isCatppuccin = cfg.theme == "catppuccin";
in {
  imports = [./catppuccin];
  options = {
    theming = {
      enable = mkEnableOption "themes";
      theme = mkOption {
        default = "catppuccin";
        type = types.enum [
          "catppuccin"
          "rose_pine"
        ];
        example = "rose_pine";
        description = lib.mdDoc ''
          Selects the theme for all apps themes using home-manager.
        '';
      };
      variant = mkOption {
        default =
          if isCatppuccin
          then "macchiato"
          else "";
        type =
          if isCatppuccin
          then
            types.enum [
              "latte"
              "frappe"
              "macchiato"
              "mocha"
            ]
          else types.enum [];
      };
      accent = mkOption {
        default =
          if isCatppuccin
          then "mauve"
          else "";
        type =
          if isCatppuccin
          then
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
          else types.enum [];
      };
    };
  };
}
