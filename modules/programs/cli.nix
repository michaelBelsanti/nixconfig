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
        imports = [ inputs.nix-index-database.hmModules.nix-index ];
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

          # Nix
          deadnix
          inputs.nilla-cli.packages.${system}.default
          inputs.nix-alien.packages.${system}.default
          nh
          nix-init
          nix-inspect
          nixos-rebuild-ng
          nixpkgs-review
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
          codeberg-cli
          difftastic
          dogdns
          du-dust
          edir
          eternal-terminal
          fd
          gdu
          gh
          gh-dash
          glow
          imagemagick
          inotify-tools
          isd
          nitch
          nvtopPackages.full
          ouch
          progress
          procs
          psmisc
          rclone
          ripgrep
          sd
          superfile
          systeroid
          try
          waypipe
          xxd
        ];
      };
  };
}
