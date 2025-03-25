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
        kdePackages.kdenlive
        remmina
        (bottles.override { removeWarningPopup = true; })
        # varia # TODO #380746
        quickemu
        proton-pass
        zotero

        (python3.withPackages (python-pkgs: [
          python-pkgs.pandas
          python-pkgs.requests
        ]))

        lan-mouse

        jellyfin-media-player
        tetrio-desktop
        element-desktop
        kdePackages.filelight
        gnome-frog
        pomodoro
        wike

        legcord
        goofcord

        obsidian
      ]
      ++ (with inputs; [
        mypkgs.packages.${system}.grayjay
      ]);
  };
}
