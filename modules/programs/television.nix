{
  unify,
  pkgs,
  lib,
  ...
}:
let
  settingsFormat = pkgs.formats.toml { };
  television-config = {
    shell_integration.commands = {
      hx = "files";
    };
  };
in
unify.module {
  name = "programs.television";
  options.programs.television = {
    enable = unify.boolOption false;
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = television-config;
    };
  };

  nixos.ifEnabled.environment.systemPackages = [ pkgs.television ];
  home.ifEnabled =
    { cfg, ... }:
    {
      xdg.configFile = {
        "television/config.toml".source = settingsFormat.generate "television-config" cfg.settings;
      };
      programs.fish.interactiveShellInit = "tv init fish | source";
    };
}
