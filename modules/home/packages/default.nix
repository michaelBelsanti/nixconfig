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

    ## Programming/Scripting
    # I use devshells for projects, but keep these installed for starting small projects easily
    # Rust
    rustc
    cargo
    gcc
    rust-analyzer
    taplo
    clippy
    # Python
    poetry
    pipx
    python3Packages.python-lsp-server
    # Haskell
    ghc
    haskell-language-server
    # Bash
    nodePackages.bash-language-server
    shellcheck

    # Other language servers
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
    nix-update

    # Notetaking
    marksman
    glow

    # Other CLI tools that are part of my workflow
    nitch
    bottom
    cheat
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
    difftastic
  ];
}
