{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.wayland;
in
{
  options.desktop.wayland.enable = mkBoolOpt false "Enable recommended variables and packages for Wayland.";
  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        wl-clipboard
        qt6.qtwayland
      ];
      sessionVariables = lib.mkDefault {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
      };
    };
    services.xserver = lib.mkDefault {
      desktopManager.plasma5.useQtScaling = true;
      displayManager.sddm.wayland.enable = true;
      displayManager.gdm.wayland = true;
    };
  };
}
