{ config, pkgs, ... }:
{
  imports = 
    [
      ../../packages/desktop/user.nix
    ];
  home.file = { };
}
