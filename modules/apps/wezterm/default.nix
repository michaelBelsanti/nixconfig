{ withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.wezterm = pkgs.wezterm.overrideAttrs (
        final: prev: {
          patches = (prev.patches or [ ]) ++ [
            (pkgs.fetchpatch {
              url = "https://github.com/wezterm/wezterm/commit/3f062e0aa1924dc5666a57b0e7d065cc26a3b29b.patch";
              hash = "sha256-o9nVO91R+eOMdtJM+8X2yHI0ejllbv4lC0aLW8ua4ok=";
            })
          ];
        }
      );
    };
  styx.apps._.wezterm = {
    homeManager =
      { pkgs, ... }:
      {
        programs.wezterm = {
          enable = true;
          package = (withSystem pkgs.stdenv.hostPlatform.system (p: p.config.packages.wezterm));
          extraConfig = builtins.readFile ./config.lua;
        };
      };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          (withSystem pkgs.stdenv.hostPlatform.system (p: p.config.packages.wezterm))
        ];
        xdg.terminal-exec.settings.default = [ "org.wezfurlong.wezterm.desktop" ];
      };
  };
}
