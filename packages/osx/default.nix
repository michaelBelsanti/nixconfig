{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    cachix
    aria2
    tealdeer
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
    
    nil
    nix-tree
    nix-index
  ];
}
