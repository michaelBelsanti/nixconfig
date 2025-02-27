{ delib, pkgs, ... }:
delib.module {
  name = "packages.cli";
  options = delib.singleEnableOption true;
  home.always.home.packages = with pkgs; [
    # Dev
    lazyjj
    lazygit
    devenv
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
    pipx
    uv
    # Haskell
    ghc
    # JS
    bun

    # Nix
    cachix
    deadnix
    manix
    nh
    nix-alien
    nix-init
    nix-inspect
    nix-output-monitor
    nixpkgs-review
    nix-tree
    nix-update
    nurl
    statix
    vulnix

    # Other CLI tools that are part of my workflow
    nitch
    nvtopPackages.full
    cheat
    edir
    gdu
    glow
    du-dust
    lf
    traceroute
    whois
    cachix
    aria2
    ouch
    lsof
    dig
    fd
    ripgrep
    edir
    dogdns
    xxd
    clipboard-jh
    choose
    psmisc
    difftastic
    vhs
    rclone
    inotify-tools
    progress
    try
    inetutils
    waypipe
    codeberg-cli
    gh
    gh-dash
    isd
    systeroid
    sd
    distrobox
    nfs-utils
    file
    git
    gptfdisk
    killall
    unrar
    unzip
    wget
    imagemagick
    ffmpeg
  ];
}
