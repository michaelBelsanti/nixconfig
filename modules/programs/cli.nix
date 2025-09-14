{ inputs, ... }:
{
  unify = {
    nixos = {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];
      programs.nix-index-database.comma.enable = true;
    };
    home =
      { pkgs, ... }:
      {
        imports = [ inputs.nix-index-database.homeModules.nix-index ];
        programs.nix-index-database.comma.enable = true;
        home.packages = with pkgs; [
          # essential utils
          file
          git
          gptfdisk
          iputils
          killall
          pciutils
          traceroute
          unrar
          unzip
          usbutils
          wget
          whois

          # Dev
          lazyjj
          lazygit
          jq
          ## Programming/Scripting
          # I use devshells for projects, but keep these installed for starting small projects easily
          # Rust
          rustc
          cargo
          gcc
          clippy
          rust-script
          # Go
          go
          # Python
          uv
          poetry
          (python3.withPackages (python-pkgs: [
            python-pkgs.pandas
            python-pkgs.requests
          ]))
          virtualenv

          # Nix
          deadnix
          inputs.nilla-cli.packages.${system}.default
          inputs.nix-alien.packages.${system}.default
          lixPackageSets.latest.nix-direnv
          lixPackageSets.latest.nixpkgs-review
          nh
          nix-init
          nix-inspect
          nixos-rebuild-ng
          nix-output-monitor
          nix-tree
          nix-update
          npins
          nurl
          statix
          vulnix

          # nice to have tools
          aria2
          choose
          clipboard-jh
          difftastic
          dogdns
          dua
          du-dust
          edir
          fd
          gdu
          gh
          glow
          imagemagick
          inotify-tools
          isd
          lurk
          mprocs
          nitch
          nvtopPackages.full
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
