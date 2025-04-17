{
  delib,
  pkgs,
  inputs,
  host,
  config,
  wrapper-manager,
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
      (warpd.override {
        withWayland = config.myconfig.desktops.wayland;
        withX = !config.myconfig.desktops.wayland;
      })
      (wrapper-manager.lib.build {
        inherit pkgs;
        modules = lib.singleton {
          wrappers.obsidian = {
            basePackage = (obsidian.override { electron = electron_35; });
            flags = [ "--enable-unsafe-webgpu" ];
          };
        };
      })
    ];
    # ++ (with inputs; [
    #   mypkgs.packages.${system}.grayjay
    # ]);
  };
}
