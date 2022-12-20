{ config, pkgs, lib, flakePath, ... }:
let
  loadEnvVars = n: v: ''"${n}": "${toString v}"'';

  loadEnv = vars: ''load-env { ${lib.concatStringsSep ", " (lib.mapAttrsToList loadEnvVars vars)} }'';
in
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
      extraEnv = ''${loadEnv config.home.sessionVariables}'';
    };
  };
}
