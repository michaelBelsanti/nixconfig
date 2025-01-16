{
  delib,
  pkgs,
  lib,
  inputs,
  host,
  config,
  ...
}:
delib.module rec {
  name = "packages.gui";
  options = delib.singleEnableOption host.hasGUI;
  home.always.imports = [ inputs.wrapper-manager.homeModules.default ];
  nixos.ifEnabled = {
    environment.systemPackages = home.ifEnabled.home.packages ++ [
        pkgs.doas-sudo-shim
    ];
  };
  home.ifEnabled = {
    home.packages =
      with pkgs;
      [
        firefox
        libreoffice
        hunspell
        hunspellDicts.en_US-large
        kdenlive
        remmina
        bottles
        wl-clipboard
        affine
        localsend
        tidal-hifi
        varia
        # quickemu
        proton-pass
        zotero

        (python3.withPackages (python-pkgs: [
          python-pkgs.pandas
          python-pkgs.requests
        ]))

        input-leap

        # Editor
        helix
        (pkgs.buildFHSEnv {
          name = "zed";
          targetPkgs =
            pkgs: with pkgs; [
              zed-editor
            ];
          runScript = "zed";
        })

        # Containers
        distrobox
        podman-compose

        # NFS
        nfs-utils

        # Packages distros will probably already have
        file
        git
        gptfdisk
        killall
        unrar
        unzip
        wget

        jellyfin-media-player
        protonvpn-gui
        tetrio-desktop
        element-desktop
        imagemagick
        ffmpeg
        filelight
        gnome-frog
        pomodoro
        wike

        # Not in modules/gaming.nix because any device can handle retro games
        retroarch-full

        vesktop
        ghostty
      ]
      ++ (with inputs; [
        mypkgs.packages.${system}.grayjay-desktop
      ]);

    # wrapper-manager.packages.gui = {
      # wrappers.vesktop = {
        # arg0 = lib.getExe pkgs.vesktop;
        # appendArgs = [ "--disable-features=WebRtcAllowInputVolumeAdjustment" ];
        # xdg.desktopEntryenable = true;
      # };
    # };
  };
}
