{
  unify.modules.workstation = {
    home =
      { pkgs, ... }:
      {
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
            withWayland = true;
            withX = false;
          })
          obsidian
          grayjay
          orca-slicer
        ];
      };
  };
}
