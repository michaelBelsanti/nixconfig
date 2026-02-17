{
  styx.apps._.coreutils.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        aria2
        choose
        difftastic
        doggo
        dua
        dust
        edir
        eva # calculator repl
        fd
        file
        gdu
        gh
        git
        glow
        gptfdisk
        hexyl
        imagemagick
        inotify-tools
        isd
        killall
        lemmeknow
        lurk
        mprocs
        ouch
        pciutils
        procs
        progress
        psmisc
        psutils
        python3
        rclone
        ripgrep
        ripgrep-all
        rsync
        sd
        strace
        # systeroid # TODO
        tcpdump
        traceroute
        try
        unrar
        unzip
        usbutils
        waypipe
        wget
        whois
      ];
    };
}
