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
          file
          git
          gptfdisk
          psutils
          killall
          pciutils
          traceroute
          unrar
          unzip
          usbutils
          wget
          whois
          aria2
          choose
          difftastic
          dogdns
          dua
          du-dust
          edir
          fd
          gdu
          gh
          glow
          isd
          lurk
          mprocs
          ouch
          procs
          progress
          psmisc
          rclone
          ripgrep
          ripgrep-all
          rsync
          sd
          strace
          systeroid
          try
          waypipe
          xxd
        ];
      };
  };
}
