{
  config,
  lib,
  flakePath,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.shells.ion;
in
{
  options.shells.ion.enable = mkBoolOpt false "Enable ion configuration.";
  config = mkIf cfg.enable {
    programs.ion = {
      enable = true;
      shellAliases = {
        nixup = "doas nixos-rebuild switch --flake ${flakePath}";
        nixUp = "nix flake update ${flakePath} && doas nixos-rebuild switch --flake ${flakePath}";
        cleanup = "doas nix-collect-garbage -d";
        lg = "lazygit";
        open = "xdg-open";
      };
      initExtra = "source-sh ~/.profile";
    };
  };
}
