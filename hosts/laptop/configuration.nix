# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, hyprland, ... }:

{

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../packages/hosts/laptop
      ../../modules/hyprland
    ];

  networking.hostName = "nix-fw"; # Define your hostname.

  boot.kernelParams = [ "acpi_backlight=native" ];
  boot.blacklistedKernelModules = [ "hid_sensor_hub" ];
  boot.loader.systemd-boot.consoleMode = "max";

  # Display shiz
  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ 
      vaapiIntel
      intel-media-driver
    ];
  };
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    # displayManager.defaultSession = "hyprland";
    desktopManager.gnome.enable = true;
  };
  services.gnome.chrome-gnome-shell.enable = true; # gnome extensions

  ### Services and hardware ###
  # Framework stuff
  services.fprintd.enable = true; # Enable fingerprint scanner 
  services.fwupd = {
    enable = true; # Enable firmware updates with `fwupdmgr update`
    enableTestRemote = true;
  };
  services.tlp.enable = true; # Battery optimization
  services.power-profiles-daemon.enable = false;

  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
