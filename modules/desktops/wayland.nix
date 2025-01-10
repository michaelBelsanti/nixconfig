{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "desktops.wayland";
  options = delib.singleEnableOption true;
  nixos.ifEnabled = {
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
    services.displayManager.sddm.wayland.enable = true;
    services.xserver = lib.mkDefault {
      desktopManager.plasma5.useQtScaling = true;
      displayManager.gdm.wayland = true;
    };
  };
}
