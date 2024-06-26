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
    nh
    nurl
    nix-init
    nix-tree
    nix-index
    nix-update
    nix-inspect

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
    nmap
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
    lnav
    xxd
    clipboard-jh
    choose
    slides
    psmisc
    difftastic
    vhs
    rclone
  ];
}
