{
  delib,
  pkgs,
  inputs,
  host,
  config,
  ...
}:
delib.module {
  name = "packages.gui";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled = {
    home.packages = with pkgs; [
      mullvad
      libreoffice
      hunspell
      hunspellDicts.en_US-large
      remmina
      (bottles.override { removeWarningPopup = true; })
      varia
      proton-pass
      jellyfin-media-player
      element-desktop
      gnome-frog
      legcord
      obsidian
      (warpd.override {
        withWayland = config.myconfig.desktops.wayland;
        withX = !config.myconfig.desktops.wayland;
      })
    ];
    # ++ (with inputs; [
    #   mypkgs.packages.${system}.grayjay
    # ]);
  };
}
