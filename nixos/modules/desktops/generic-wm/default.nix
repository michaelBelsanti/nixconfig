{
  pkgs,
  user,
  ...
}: {
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    dolphin
    ark
    selectdefaultapplication
    wmctrl
    gwenview
    pamixer
    pavucontrol
    libsForQt5.okular
    celluloid

    qt5ct
    breeze-icons
    libsForQt5.lightly
    libsForQt5.baloo # dolphin
  ];

  systemd.user.services.gnome-polkit = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  home-manager.users.${user} = {
    home.packages = with pkgs; [
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
    services = {
      dunst = {
        enable = true;
        settings = {
          urgency_low.timeout = 3;
          urgency_normal.timeout = 6;
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
  };
}
