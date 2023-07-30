{
  pkgs,
  user,
  ...
}: {
  imports = [../default.nix];
  services.xserver.windowManager.i3.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-kde];
  environment.systemPackages = with pkgs; [
    picom
    betterlockscreen
    shotgun
    hacksaw
    rofi
    feh
    dunst
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
        workspaceAutoBackAndForth = true;
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
      dunst = {
        enable = true;
        settings = {
          urgency_low.timeout = 3;
          urgency_normal.timeout = 8;
          urgency_critical.timeout = 0;
          global = {
            follow = "mouse";
            width = 350;
            height = 250;
            origin = "top-right";
            offset = "15x40";
            scale = 0;
            notification_limit = 0;
            progress_bar = "true";
            progress_bar_height = 10;
            progress_bar_frame_width = 1;
            progress_bar_min_width = 100;
            progress_bar_max_width = 150;
            indicate_hidden = "yes";
            transparency = 0;
            separator_height = 2;
            padding = 10;
            horizontal_padding = 10;
            text_icon_padding = 0;
            frame_width = 3;
            sort = "yes";
            font = "Sans 12";
            line_height = 0;
            markup = "full";
            # format = "<b>%a: %s</b>\n%b\n%p"
            alignment = "left";
            vertical_alignment = "center";
            show_age_threshold = 30;
            browser = "${pkgs.xdg-utils}/bin/xdg-open";
          };
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
            p) pause_noti exit;; u) unpause_noti exit;;
          esac
        else
          echo "Usage: -p 'pause', -u 'unpause' -t 'toggle'"
        fi
      '')
    ];
  };
}
