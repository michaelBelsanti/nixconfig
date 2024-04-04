{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.desktop.hyprland;
  user = config.users.mainUser;
in
{
  options.desktop.hyprland.enable = mkBoolOpt false "Enable hyprland configuration.";
  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    services.xserver.displayManager.defaultSession = "hyprland";
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    environment.systemPackages = with pkgs; [
      # QT stuff
      kdePackages.breeze
      kdePackages.breeze-icons
      libsForQt5.breeze-icons

      # inputs.hyprsome.packages.${pkgs.system}.default
      custom.hyprsome
      swaybg
      mpvpaper
      swaynotificationcenter
      walker

      pavucontrol
      overskride

      gnome.nautilus
      nautilus-open-any-terminal
      celluloid
      loupe

      wl-clipboard
      rofi-wayland
      grimblast
      swaylock
      (writeShellScriptBin "dnd" ''
        pause_noti () {
          makoctl dismiss -a
          makoctl mode -a dnd
        }

        unpause_noti () {
          makoctl mode -r dnd
        }

        toggle_noti () {
          if [ "$(makoctl mode | tail -n 1)" = "default" ]; then
            pause_noti
          else
            unpause_noti
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
      (writeScriptBin "walker-power" ''
        #!${lib.getExe pkgs.nushell}

        def main [] {
          let shut_down = [["label" "exec"]; ["Shutdown" "systemctl poweroff"]]
          let reboot = [["label" "exec"]; ["Reboot" "systemctl reboot"]]
          let suspend = [["label" "exec"]; ["Suspend" "systemctl suspend"]]
          let log_out = [["label" "exec"]; ["Log out" "hyprctl dispatch exit"]]

          $shut_down | append $reboot | append $suspend | append $log_out | to json
        }
      '')
    ];
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };
    snowfallorg.users.${user}.home.config = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd = {
          enable = true;
          variables = [ "--all" ];
        };
        settings = import ./settings.nix pkgs;
      };
      services.udiskie.enable = true;
      programs.ironbar = {
        enable = true;
        config = import ./ironbar.nix;
      };
      xdg.desktopEntries = {
        "power-off" = {
          name = "Power off";
          exec = "systemctl poweroff";
          icon = "";
        };
        "reboot" = {
          name = "Reboot";
          exec = "systemctl reboot";
          icon = "";
        };
        "suspend" = {
          name = "Suspend";
          exec = "systemctl suspend";
          icon = "";
        };
        "log-out" = {
          name = "Log out";
          exec = "hyprctl dispatch exit";
          icon = "";
        };
      };
    };
  };
}
