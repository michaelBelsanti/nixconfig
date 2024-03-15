{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.plasma;
  user = config.users.mainUser;
in
{
  options.desktop.plasma.enable = mkBoolOpt false "Enable plasma configuration.";
  config = mkIf cfg.enable {
    snowfallorg.users.${user}.home.config = {
      programs.plasma.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
    services.xserver.displayManager = {
      sddm.enable = true;
      defaultSession = "plasma";
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
