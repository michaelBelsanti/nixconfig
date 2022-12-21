# System configuration module for Hyprland using official flake

# TODO
# Nvidia variable can be set for Nvidia gpu compatibility, do NOT set if not Nvidia

{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.programs.hyprland.enable {
    programs.hyprland.recommendedEnvironment = true;
    services.xserver.displayManager.defaultSession = "hyprland";
    environment.systemPackages = with pkgs; [
      swaybg
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      brightnessctl
      wl-clipboard
      wezterm
      alacritty
      rofi-wayland
      dolphin
      libsForQt5.ark
      selectdefaultapplication
      (polkit_gnome.overrideAttrs (_oldAttrs: {
        postFixup = ''
          mkdir $out/bin
          ln -s $out/libexec/polkit-gnome-authentication-agent-1 $out/bin/polkit-gnome
        '';
      })) # Puts polkit-gnome in my path
      xsettingsd
      nsxiv
      pamixer
      wmctrl
      grim
      slurp
      swaylock
      networkmanagerapplet
      pavucontrol
    ];

    # nixpkgs.overlays = [
    #   (self: super: {
    #     discord-openasar = pkgs.symlinkJoin {
    #       name = "discord-openasar";
    #       paths = [ super.discord-openasar];
    #       buildInputs = [ pkgs.makeWrapper ];
    #       postBuild = ''
    #         wrapProgram $out/opt/Discord/Discord --set GDK_SCALE 2 --set XCURSOR_SIZE 64
    #       '';
    #     };
    #     jetbrains = super.jetbrains // {
    #       idea-community = pkgs.symlinkJoin {
    #         name = "idea-community";
    #         paths = [ super.jetbrains.idea-community ];
    #         buildInputs = [ pkgs.makeWrapper ];
    #         postBuild = ''
    #           wrapProgram $out/bin/idea-community --set GDK_SCALE 2 --set XCURSOR_SIZE 64
    #         '';
    #       };
    #     };
    #     jflap = pkgs.symlinkJoin {
    #       name = "jflap";
    #       paths = [ super.jflap ];
    #       buildInputs = [ pkgs.makeWrapper ];
    #       postBuild = ''
    #         wrapProgram $out/bin/jflap --set GDK_SCALE 2 --set XCURSOR_SIZE 64
    #       '';
    #     };
    #   })
    # ];

    # hardware.nvidia.modesetting.enable = true;
    # environment.variables = {
    #   LIBVA_DRIVER_NAME = "nvidia";
    # CLUTTER_BACKEND = "wayland";
    # XDG_SESSION_TYPE = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # MOZ_ENABLE_WAYLAND = "1";
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_BACKEND = "vulkan";
    # QT_QPA_PLATFORM = "wayland";
    # GDK_BACKEND = "wayland";
    # };
  };
}
