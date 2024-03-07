{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.desktop.hyprland;
  user = config.users.mainUser;
in
{
  options.desktop.hyprland.enable = mkBoolOpt false "Enable hyprland configuration.";
  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
    services.xserver.displayManager.defaultSession = "hyprland";
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
    };
    programs.nm-applet.enable = true;
    environment.systemPackages = with pkgs; [
      swaybg
      (waybar.overrideAttrs (
        oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }
      ))
      brightnessctl
      wl-clipboard
      rofi-wayland
      grimblast
      swaylock
      brightnessctl
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
    ];
    snowfallorg.user.${user}.home.config = {
      apps.rofi.enable = true;
      wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hypr/hyprland.conf;
      };
    };
  };
}
