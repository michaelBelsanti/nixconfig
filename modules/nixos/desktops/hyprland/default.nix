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
    desktop.wayland.enable = true;
    programs.hyprland.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.defaultSession = "hyprland";
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    environment.systemPackages = with pkgs; [
      # QT stuff
      kdePackages.breeze
      kdePackages.breeze-icons

      # inputs.hyprsome.packages.${pkgs.system}.default
      custom.hyprsome
      hyprlock
      swaybg
      mpvpaper
      swaynotificationcenter

      pwvucontrol
      overskride
      file-roller

      nautilus
      nautilus-open-any-terminal
      celluloid
      loupe

      wl-clipboard
      grimblast
      hyprpicker
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
    services.gnome.gnome-keyring.enable = true;
    programs.gamemode.settings = {
      custom = {
        start = "swaync-client -dn";
        end = "swaync-client -df";
      };
    };
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
      # requires ironbar input
      # programs.ironbar = {
      #   enable = true;
      #   config = import ./ironbar.nix;
      # };
      # requires walker input
      # programs.walker = import ./walker.nix;
      programs.hyprlock = {
        enable = true;
        settings = {
          backgrounds = lib.lists.singleton {
            path = "~/.background-image";
            blur_passes = 3;
            blur_size = 8;
          };
        };
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
