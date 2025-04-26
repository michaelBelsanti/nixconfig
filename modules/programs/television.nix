{
  pkgs,
  lib,
  mylib,
  config,
  ...
}:
let
  cfg = config.programs.television;
  settingsFormat = pkgs.formats.toml { };
  television-config = {
    shell_integration.commands = {
      hx = "files";
    };
  };
in
{
  options.programs.television = {
    enable = mylib.mkBool false;
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = television-config;
    };
  };

  config = lib.mkIf cfg.enable {
    nixos.environment.systemPackages = [ pkgs.television ];
    home = {
      xdg.configFile."television/config.toml".source =
        settingsFormat.generate "television-config" cfg.settings;
      programs.fish.interactiveShellInit = "tv init fish | source";
    };
  };
}
