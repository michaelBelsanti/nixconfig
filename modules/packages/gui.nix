{
  delib,
  pkgs,
  inputs,
  host,
  ...
}:
delib.module rec {
  name = "packages.gui";
  options = delib.singleEnableOption host.isWorkstation;
  nixos.ifEnabled = {
    environment.systemPackages = home.ifEnabled.home.packages ++ [
      pkgs.doas-sudo-shim
    ];
  };
  home.ifEnabled = {
    home.packages =
      with pkgs;
      [
        libreoffice
        hunspell
        hunspellDicts.en_US-large
        kdenlive
        remmina
        (bottles.override { removeWarningPopup = true; })
        localsend
        tidal-hifi
        # varia
        # quickemu
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
        filelight
        gnome-frog
        pomodoro
        wike

        vesktop

        obsidian
      ]
      ++ (with inputs; [
        mypkgs.packages.${system}.grayjay-desktop
      ]);
  };
}
