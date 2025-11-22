{
  styx.apps._.wezterm = {
    homeManager.programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./config.lua;
    };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.wezterm ];
        xdg.terminal-exec.settings.default = [ "org.wezfurlong.wezterm.desktop" ];
      };
  };
}
