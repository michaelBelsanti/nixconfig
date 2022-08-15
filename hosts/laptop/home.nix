{ config, pkgs, ... }:

{
  imports = 
    [
      ../../packages/laptop/user.nix
    ];
  home.file = { };
}
