{ config, pkgs, lib, flakePath, ... }:
{
  programs = {
    nushell = {
      enable = true;
      envFile.source = ./env.nu;
      configFile.source = ./config.nu;
      extraConfig = ''
        nitch

        alias ls = ls -a
        alias lg = lazygit
        alias nixup = doas nixos-rebuild switch --flake '${flakePath}'
        alias nixUp = nix flake update ${flakePath} && doas nixos-rebuild switch --flake '${flakePath}'
      '';
      extraEnv = ''
        sh -c "source /etc/profile"
        sh -c "source ~/.profile"
      '';
    };
  };
}
