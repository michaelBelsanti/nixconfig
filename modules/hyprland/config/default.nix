{ lib, config, pkgs, ...}:
{
  imports = [
    ../../rofi    
  ];

  xdg.configFile = {
    # hyprland = {
      # source = ./hyprland.conf;
      # target = "hypr/hyprland.conf";
    # };
    waybar = {
      source = ./waybar;
      recursive = true;
    };
    xsettingds = {
      target = "xsettingsd/xsettingsd.conf";
      text = ''
        Xft/Hinting 1
        Xft/HintStyle "hintslight"
        Xft/Antialias 1
        Xft/RGBA "rgb"
      '';
    };
  };
  xresources.properties = {
    "Xcursor.size" = lib.mkForce "64";
  };
}
