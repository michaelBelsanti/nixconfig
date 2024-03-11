{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.desktop.plasma;
  user = config.users.mainUser;
in
{
  options.desktop.plasma.enable = mkBoolOpt false "Enable plasma configuration.";
  # Import automatically generated plasma-manager config
  # Generated using 'rc2nix' or `nix run github:pjones/plasma-manager`
  config = mkIf cfg.enable {
    snowfallorg.users.${user}.home.config = {
      programs.plasma.enable = true;
    };
    desktop.wayland.enable = true;
    services.xserver = {
      desktopManager.plasma6.enable = true;
      displayManager.defaultSession = "plasma";
      # displayManager.defaultSession = "plasmawayland";
    };

    environment.systemPackages = with pkgs; [
      # Theming / Customization
      (catppuccin-kde.override {
        flavour = [ "macchiato" ];
        accents = [ "mauve" ];
      })
      # lightly-qt
      # libsForQt5.lightly
      # libsForQt5.polonium
      custom.polonium

      ark
      krusader
      haruna
      yakuake
      partition-manager

      rc2nix
    ];
  };
}
