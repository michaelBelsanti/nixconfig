{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      wl-clipboard
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM="wayland";
    };
  };
  services.xserver = {
    desktopManager.plasma5.useQtScaling = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.gdm.wayland = true;
  };
}
