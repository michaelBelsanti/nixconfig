{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "packages.cli";
  options = delib.singleEnableOption true;
  home.always.home.packages = with pkgs; [
    # essential utils
    file
    git
    gptfdisk
    inetutils
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
    # inputs.nilla-cli.nilla.config.packages.nilla.build.x86_64-linux
    inputs.nix-alien.packages.${system}.nix-alien
    manix
    nh
    nix-init
    nix-inspect
    nixos-rebuild-ng
    nix-output-monitor
    nixpkgs-review
    nix-tree
    nix-update
    npins
    nurl
    statix
    vulnix

    # nice to have tools
    aria2
    cachix
    cheat
    choose
    clipboard-jh
    codeberg-cli
    difftastic
    dig
    distrobox
    dogdns
    du-dust
    edir
    eternal-terminal
    fd
    ffmpeg
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
    psmisc
    rclone
    ripgrep
    sd
    superfile
    systeroid
    try
    vhs
    waypipe
    xxd
  ];
}
