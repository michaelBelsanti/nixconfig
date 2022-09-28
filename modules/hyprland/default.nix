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
    rofi-wayland
    cinnamon.nemo
    xfce.thunar xfce.thunar-volman xfce.thunar-archive-plugin
    selectdefaultapplication
    lxsession
    nsxiv
    pamixer
    wmctrl
    grim
    slurp
  ];

  # Good defaults for standalone apps
  xdg.mime.defaultApplications = {
    # Browser
    "application/pdf" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";

    # Images
    "image/bmp" = "nsxiv.desktop";
    "image/x-portable-anymap" = "nsxiv.desktop";
    "image/tiff" = "nsxiv.desktop";
    "image/png" = "nsxiv.desktop";
    "image/x-eps" = "nsxiv.desktop";
    "image/gif" = "nsxiv.desktop";
    "image/avif" = "nsxiv.desktop";
    "image/x-portable-pixmap" = "nsxiv.desktop";
    "image/jpeg" = "nsxiv.desktop";
    "image/jp2" = "nsxiv.desktop";
    "image/webp" = "nsxiv.desktop";
    "image/x-xpixmap" = "nsxiv.desktop";
    "image/x-tga" = "nsxiv.desktop";
    "image/jxl" = "nsxiv.desktop";
    "image/heif" = "nsxiv.desktop";
    "image/x-portable-graymap" = "nsxiv.desktop";
    "image/svg+xml" = "nsxiv.desktop";
    "image/x-portable-bitmap" = "nsxiv.desktop";
    
    # Text
    "text/plain" = "helix.desktop";
    "text/x-patch" = "helix.desktop";
  };
}
