{
  pkgs,
  config,
  wrapper-manager,
  mylib,
  lib,
  ...
}:
{
  options.packages.gui.enable = mylib.mkEnabledIf "workstation";
  config.home.home.packages = lib.mkIf config.packages.gui.enable (
    with pkgs;
    [
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
        withWayland = config.desktops.wayland;
        withX = !config.desktops.wayland;
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
    ]
  );
  # ++ (with inputs; [
  #   mypkgs.packages.${system}.grayjay
  # ]);
}
