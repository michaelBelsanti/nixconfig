{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    cachix
    aria2
    unrar
    unzip
    bat
    exa
    fd
    ripgrep
    fzf
    imagemagick
    edir
    lf
    bottom
    devenv
    lazygit
    distrobox
    so
    
    rnix-lsp
    nix-tree
    nix-index
  ];
}
