{
  pkgs,
  user,
  ...
}: {
  imports = [../generic-wm];
  services.xserver.windowManager.i3.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-kde];
  environment.systemPackages = with pkgs; [
    picom
    betterlockscreen
    shotgun
    hacksaw
    rofi
    feh
    xdotool
    xorg.xkill
    xclip
    autotiling
    (polybar.override {
      i3Support = true;
      pulseSupport = true;
    })
  ];
  home-manager.users.${user} = {
    imports = [../rofi];
    programs.kitty.enable = true;
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        keybindings = {};
        modes = {};
        bars = [];
        fonts = {};
        terminal = "kitty";
      };
      extraConfig = builtins.readFile ./config;
    };
    services = {
      betterlockscreen = {
        enable = true;
        arguments = ["--blur" "--off 30"];
      };
      picom = {
        enable = true;
        fade = true;
        fadeDelta = 2;
        menuOpacity = 0.8;
        shadowExclude = [
          "name = 'Notification'"
          "class_g = 'Conky'"
          "class_g ?= 'Notify-osd'"
          "class_g = 'Cairo-clock'"
          "class_g = 'slop'"
          "class_g = 'Polybar'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        fadeExclude = [
          "class_g = 'slop'" # maim
        ];
        wintypes = {
          popup_menu = {opacity = 0.8;};
          dropdown_menu = {opacity = 0.8;};
        };
        settings = {
          backend = "glx";
          round-borders = 1;
          corner-radius = 6;
          rounded-corners-exclude = [
            "class_g = 'Polybar'"
            "window_type = 'dock'"
            "window_type = 'desktop'"
          ];
          blur = {
            method = "dual_kawase";
            strength = 7;
            background = true;
          };
          blur-background-exclude = [
            "window_type = 'desktop'"
            "window_type = 'menu'"
            "class_g = 'pensela'"
            "name = 'Discover Text'"
            "name = 'Discover Voice'"
            "name = 'peek'"
            "name = 'Peek'"
            "class_g = 'firefox' && window_type = 'utility'"
            "class_g = 'slop'"
            "_GTK_FRAME_EXTENTS@:c"
          ];
        };
      };
    };
    xdg.configFile = {
      # picom = {
      #   source = ./picom;
      #   recursive = true;
      # };
      polybar = {
        source = ./polybar;
        recursive = true;
      };
    };
    # Scripts
    home.packages = with pkgs; [
      (writeShellScriptBin "togpicom" ''
        stop () {
          killall picom
        }
        start () {
          picom --unredir-if-possible
        }

        pgrep -x picom
        if [ $? -ne 0 ]
          then ALIVE=0
          else ALIVE=1
        fi;

        if getopts 'tpu' flag; then
          case "$flag" in
            t) if [ $ALIVE -eq 1 ]; then stop; else start; fi; exit;;
            p) stop exit;;
            u) start exit;;
          esac
        else
          echo "Usage: -p 'pause', -u 'unpause' -t 'toggle'"
        fi
      '')
    ];
  };
}
