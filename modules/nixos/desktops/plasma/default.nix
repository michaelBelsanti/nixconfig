{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.plasma;
  user = config.users.mainUser;
in {
  options.desktop.plasma.enable = mkBoolOpt false "Enable plasma configuration.";
  # Import automatically generated plasma-manager config
  # Generated using 'rc2nix' or `nix run github:pjones/plasma-manager`
  config = mkIf cfg.enable {
    snowfallorg.user.${user}.home.config = {
      imports = [./plasma-manager.nix];
      programs.plasma.enable = true;
    };
    desktop.wayland.enable = true;
    services.xserver = {
      desktopManager.plasma5.enable = true;
      displayManager.defaultSession = "plasmawayland";
    };

    environment.systemPackages = with pkgs; [
      # Theming / Customization
      (catppuccin-kde.override {
        flavour = ["macchiato"];
        accents = ["mauve"];
      })
      # lightly-qt
      # libsForQt5.lightly
      libsForQt5.polonium

      ark
      krusader
      haruna
      yakuake
      partition-manager

      rc2nix
    ];
  };
}
