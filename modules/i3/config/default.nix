{ config, pkgs, ...}:
{
  imports = [
    ../../rofi
  ];
  
  xdg.configFile = {
    i3 = {
      source = ./config;
      target = "i3/config";
    };
    picom = {
      source = ./picom.conf;
      target = "picom/picom.conf";
    };
    polybar = {
      source = ./polybar;
      recursive = true;
    };
    dunst = {
      source = ./dunstrc;
      target = "dunst/dunstrc";
    };
  };
  home.packages = with pkgs; [
  (writeScriptBin "togpicom" ''
    pgrep -x picom
    if [ $? -ne 0 ]
    then
        picom --unredir-if-possible --experimental-backends
    else
        pkill picom
    fi;
    '')

    (writeShellScriptBin "togdnd" ''
      pause_noti () {
        dunstctl close-all
        dunstctl set-paused true
        polybar-msg action dnd module_show
      }

      unpause_noti () {
        dunstctl set-paused false
        polybar-msg action dnd module_hide
      }

      toggle_noti () {
        if [ "$(dunstctl is-paused)" = "true" ]; then
          unpause_noti
        else
          pause_noti
        fi
      }

      if getopts 'tpu' flag; then
        case "$flag" in 
          t) toggle_noti exit;;
          p) pause_noti exit;;
          u) unpause_noti exit;;
        esac
      else
        echo "Usage: -p 'pause', -u 'unpause' -t 'toggle'"
      fi
    '')
  ];
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
