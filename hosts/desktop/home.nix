{ config, pkgs, ... }:
{
  imports = 
    [
      ../../packages/desktop/user.nix
      ../../modules/zsh/desktop
    ];
  home.file = { };
}
