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
    inputs.nilla-cli.packages.${system}.nilla
    inputs.nix-alien.packages.${system}.nix-alien
    nh
    nix-init
    nix-inspect
    nixos-rebuild-ng
    nixpkgs-review
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
    distrobox
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
    psmisc
    rclone
    ripgrep
    sd
    superfile
    # systeroid # TODO
    try
    waypipe
    xxd
  ];
}
