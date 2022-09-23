{ config, pkgs, ...}:
{
  programs.hyprland.enable = true;
  programs.hyprland.recommendedEnvironment = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      });
    })
  ];
  environment.systemPackages = with pkgs; [
    swaybg
    waybar
    brightnessctl
    wl-clipboard
    alacritty
    rofi
    cinnamon.nemo
    selectdefaultapplication
    lxsession
    nsxiv
    pamixer
    wmctrl
    grim
    slurp
  ];
}
