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
      gnome.nautilus
      nautilus-open-any-terminal
      gnome.file-roller
      wmctrl
      selectdefaultapplication
      (polkit_gnome.overrideAttrs (oldAttrs: { postFixup = ''
        mkdir $out/bin
        ln -s $out/libexec/polkit-gnome-authentication-agent-1 $out/bin/polkit-gnome
      '';})) # So polkit-gnome is in my path
      nsxiv
      pamixer
      xdotool
      xorg.xkill
      xclip
      pamixer
      autotiling
      (polybar.override { i3GapsSupport = true; pulseSupport = true; })
      networkmanagerapplet
      pavucontrol
    ];
  };
}
