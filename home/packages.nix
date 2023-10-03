# Any packages that I would want outside of NixOS is installed with home-manager
# These will be installed in both a NixosConfiguration and HomeConfiguration
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Dev
    helix
    lazygit
    devenv
    so

    ## Programming/Scripting
    # I use devshells for projects, but keep these installed for starting small projects easily
    # Rust
    rustc
    cargo
    gcc
    rust-analyzer
    taplo
    clippy
    # Haskell
    ghc
    haskell-language-server
    # Bash
    nodePackages.bash-language-server
    shellcheck
    ## Programming Classes
    nodePackages_latest.intelephense
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.typescript-language-server

    # Nix
    alejandra
    nil
    nixd
    nurl
    nix-init
    nix-tree
    nix-index

    # Notetaking
    marksman
    glow

    # Other CLI tools that are part of my workflow
    nitch
    bottom
    edir
    gdu
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
  ];
}
