{
  unify = {
    modules.workstation.home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          imagemagick
          inotify-tools
        ];
      };
    home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          aria2
          choose
          difftastic
          dogdns
          dua
          du-dust
          edir
          eva
          fd
          file
          gdu
          gh
          git
          glow
          gptfdisk
          hexyl
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
          rclone
          ripgrep
          ripgrep-all
          rsync
          sd
          strace
          systeroid
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
  };
}
