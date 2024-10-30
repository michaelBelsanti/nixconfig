# Any packages that I would want outside of NixOS is installed with home-manager
# These will be installed in both a NixosConfiguration and HomeConfiguration
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Dev
    helix
    lazygit
    devenv
    so
    jq
    ngrok
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
    # poetry
    pipx
    # Haskell
    ghc
    # JS
    bun
    nodejs

    # Nix
    cachix
    deadnix
    manix
    nh
    nix-alien
    nix-index
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
    bottom
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
    bat
    tealdeer
    lsof
    dig
    fd
    ripgrep
    skim
    ncdu
    edir
    dogdns
    xxd
    clipboard-jh
    choose
    slides
    psmisc
    difftastic
    vhs
    rclone
    inotify-tools
    progress
  ];
}
