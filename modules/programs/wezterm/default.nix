{
  unify.modules = {
    workstation = {
      nixos.xdg.terminal-exec.settings.default = [ "org.wezfurlong.wezterm.desktop" ];
      home.programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile ./config.lua;
      };
    };
    server.nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.wezterm ];
      };
  };
}
