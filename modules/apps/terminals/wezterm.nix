{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "apps.terminals.wezterm";
  options = delib.singleEnableOption false;
  home.ifEnabled = {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
