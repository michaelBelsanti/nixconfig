{ lib, config, pkgs, fetchFromGitHub, ... }:
{
  config = lib.mkIf config.services.xserver.windowManager.i3.enable {
    services.xserver.windowManager.i3.package = pkgs.i3-gaps;
    environment.systemPackages = with pkgs; [
      # picom-jonaburg
      picom # jonaburg seems to be causing performance issues in game, maybe an issue with unredir-if-possible?
      wezterm
      alacritty
      betterlockscreen
      shotgun
      hacksaw
      rofi
      feh
      dunst
      cinnamon.nemo
      wmctrl
      selectdefaultapplication
      lxsession
      nsxiv
      pamixer
      xdotool
      xorg.xkill
      xclip
      pamixer
      autotiling
      (polybar.override { i3GapsSupport = true; pulseSupport = true; })
    ];
  };
}
