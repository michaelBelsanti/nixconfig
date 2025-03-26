{
  delib,
  pkgs,
  inputs,
  host,
  ...
}:
delib.module {
  name = "packages.gui";
  options = delib.singleEnableOption host.isWorkstation;
  home.ifEnabled = {
    home.packages =
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

        (python3.withPackages (python-pkgs: [
          python-pkgs.pandas
          python-pkgs.requests
        ]))

        jellyfin-media-player
        element-desktop
        gnome-frog
        legcord
        obsidian
      ]
      ++ (with inputs; [
        mypkgs.packages.${system}.grayjay
      ]);
  };
}
