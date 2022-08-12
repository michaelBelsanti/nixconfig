{ config, pkgs, ... }:

{
  imports = 
    [
      ../../packages/framework/user.nix
    ];
  home.file = { };
}
