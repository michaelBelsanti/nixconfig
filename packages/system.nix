{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    vim
    wget
    git
    firefox
    librewolf
    discord
    rnix-lsp
    unrar
    unzip
    bottles
    gamemode
    killall
    virt-manager
    libreoffice
    tldr
    lsof
    dig 
    fd
    ripgrep
    pavucontrol
    pamixer
    dwarfs
  ];
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    montserrat
  ];
}
