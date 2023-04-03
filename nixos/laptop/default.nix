{ config, lib, pkgs, user, ... }:
# let
  # tomlFormat = pkgs.formats.toml { };
  # settings = {
  #   background = "${../../modules/themes/catppuccin/background.png}";
  #   background_fit = "Contain";
  #   gtk = {
  #     application_prefer_dark_theme = true;
  #     cursor_theme_name = "Adwaita";
  #     font_name = "Montserrat 16";
  #     icon_theme_name = "Adwaita";
  #     theme_name = "Adwaita";
  #   };
  # };
# in
{
  imports = [
    ./hardware.nix
    # ../../modules/desktop/hyprland/laptop.nix
    ../../modules/desktop/kde/laptop.nix
    # ../../modules/desktop/gnome
  ];

  networking.hostName = "nix-laptop"; # Define your hostname.

  boot = {
    kernelParams = [ "acpi_backlight=native" ];
    blacklistedKernelModules = [ "hid_sensor_hub" ];
    loader.grub.theme = pkgs.framework-grub-theme;
  };

  # Make fingerprint sensor work at boot
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  services = {
    # greetd = {
    #   # enable = true;
    #   settings = {
    #     default_session = {
    #       command = "${pkgs.cage}/bin/cage -s -- ${pkgs.regreet}/bin/regreet -c ${tomlFormat.generate "regreet.toml" settings}";
    #       user = "greeter";
    #     };
    #   };
    # };
    xserver = {
      enable = true;
      videoDrivers = [ "intel" ];
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      libinput = {
        mouse = {
          accelProfile = "flat";
          middleEmulation = false;
          additionalOptions = ''
            Option "MiddleEmulation" "off"
          '';
        };
        touchpad = { accelProfile = "adaptive"; };
      };
    };
    auto-cpufreq.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    fprintd.enable = true; # Enable fingerprint scanner
    fwupd = {
      enable = true; # Enable firmware updates with `fwupdmgr update`
      enableTestRemote = true;
      extraRemotes = [ "lvfs-testing" ];
    };
  };

  # Graphics drivers
  environment.variables = { LIBVA_DRIVER_NAME = "iHD"; };
  hardware.opengl = {
    extraPackages = with pkgs;
      [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  ### Services and hardware ###

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Framework stuff
  environment.etc."fwupd/uefi_capsule.conf".text = lib.mkForce ''
    [uefi_capsule]
    OverrideESPMountPoint=${config.boot.loader.efi.efiSysMountPoint}
    DisableCapsuleUpdateOnDisk=true
  '';

  system.stateVersion = "22.05";
}
