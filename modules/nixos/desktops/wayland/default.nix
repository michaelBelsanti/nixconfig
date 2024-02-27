{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.wayland;
in {
  options.desktop.wayland.enable = mkBoolOpt false "Enable recommended variables and packages for Wayland.";
  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        wl-clipboard
      ];
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
      };
    };
    services.xserver = {
      desktopManager.plasma5.useQtScaling = true;
      displayManager.sddm.wayland.enable = true;
      displayManager.gdm.wayland = true;
    };
  };
}
