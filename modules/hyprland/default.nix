# System configuration module for Hyprland using official flake
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia
#

{ config, pkgs, isNvidia ? false, ... }:
{
  programs.hyprland.enable = true;
  programs.hyprland.recommendedEnvironment = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  environment.systemPackages = with pkgs; [
    swaybg
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"]; }))
    brightnessctl
    wl-clipboard
    wezterm
    alacritty
    rofi-wayland
    cinnamon.nemo
    xfce.thunar xfce.thunar-volman xfce.thunar-archive-plugin gvfs
    selectdefaultapplication
    lxsession
    xsettingsd
    nsxiv
    pamixer
    wmctrl
    grim
    slurp
    swaylock
    # (pkgs.symlinkJoin {
    #   name = "jetbrains.idea-community";
    #   paths = [ pkgs.jetbrains.idea-community ];
    #   buildInputs = [ pkgs.makeWrapper ];
    #   postBuild = ''
    #     wrapProgram $out/bin/idea-community --set GDK_SCALE 2 --set XCURSOR_SIZE 64
    #   '';
    # })
   ];
  
  nixpkgs.overlays = [
    (self: super: {
      discord-canary-openasar = pkgs.symlinkJoin {
        name = "discord-canary-openasar";
        paths = [ super.discord-canary-openasar];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/opt/DiscordCanary/DiscordCanary --set GDK_SCALE 2 --set XCURSOR_SIZE 64
        '';
      };
    })
    (self: super: {
      jetbrains = super.jetbrains // {
        idea-community = pkgs.symlinkJoin {
          name = "idea-community";
          paths = [ super.jetbrains.idea-community ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/idea-community --set GDK_SCALE 2 --set XCURSOR_SIZE 64
          '';
        };
      };
    })
    (self: super: {
      jflap = pkgs.symlinkJoin {
        name = "jflap";
        paths = [ super.jflap ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/jflap --set GDK_SCALE 2 --set XCURSOR_SIZE 64
        '';
      };
    })
  ];
  
  # environment.variables = if isNvidia then 
  #   {
  #     LIBVA_DRIVER_NAME = "nvidia";
  #     XDG_SESSION_TYPE = "wayland";
  #     GBM_BACKEND = "nvidia-drm";
  #     __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #     WLR_NO_HARDWARE_CURSORS = 1;
  #   }
  #   else
  #   {};
  
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
