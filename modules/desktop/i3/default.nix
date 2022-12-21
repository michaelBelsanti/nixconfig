{ lib, config, pkgs, ... }: {
  imports = [ ../default.nix ];
  config = lib.mkIf config.services.xserver.windowManager.i3.enable {
    services.xserver.windowManager.i3.package = pkgs.i3-gaps;
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
        i3GapsSupport = true;
        pulseSupport = true;
      })
    ];
  };
}
