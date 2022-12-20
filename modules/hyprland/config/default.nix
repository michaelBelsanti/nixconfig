{ lib, ... }: {
  imports = [ ../../rofi ];

  xdg.configFile = {
    hyprland = {
      source = ./hyprland.conf;
      target = "hypr/hyprland.conf";
      onChange = "hyprctl reload";
    };
    waybar = {
      source = ./waybar;
      recursive = true;
      onChange = "hyprctl reload";
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
  xresources.properties = { "Xcursor.size" = "64"; };

  home.pointerCursor.x11.enable = false;
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    GDK_SCALE = 2;
    XCURSOR_SIZE = 64;
  };

  # Good defaults for standalone apps
  xdg.mimeApps.defaultApplications = {
    # Browser
    "application/pdf" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";

    # Images
    "image/bmp" = "nsxiv.desktop";
    "image/x-portable-anymap" = "nsxiv.desktop";
    "image/tiff" = "nsxiv.desktop";
    "image/png" = "nsxiv.desktop";
    "image/x-eps" = "nsxiv.desktop";
    "image/gif" = "nsxiv.desktop";
    "image/avif" = "nsxiv.desktop";
    "image/x-portable-pixmap" = "nsxiv.desktop";
    "image/jpeg" = "nsxiv.desktop";
    "image/jp2" = "nsxiv.desktop";
    "image/webp" = "nsxiv.desktop";
    "image/x-xpixmap" = "nsxiv.desktop";
    "image/x-tga" = "nsxiv.desktop";
    "image/jxl" = "nsxiv.desktop";
    "image/heif" = "nsxiv.desktop";
    "image/x-portable-graymap" = "nsxiv.desktop";
    "image/svg+xml" = "nsxiv.desktop";
    "image/x-portable-bitmap" = "nsxiv.desktop";

    # Text
    "text/plain" = "helix.desktop";
    "text/x-patch" = "helix.desktop";
  };
}
