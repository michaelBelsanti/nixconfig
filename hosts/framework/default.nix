# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "nix-fw"; # Define your hostname.

  # Display shiz
  hardware.opengl.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.sway.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.chrome-gnome-shell.enable = true; # gnome extensions

  ### Packages and programs ###
  environment.systemPackages = with pkgs; [
  ];
  
  ### Services and hardware ###
  # Framework stuff
  services.fprintd.enable = true; # Enable fingerprint scanner 
  services.fwupd = {
    enable = true; # Enable firmware updates with `fwupdmgr update`
    enableTestRemote = true;
  };
  services.tlp.enable = true; # Battery optimization
  services.power-profiles-daemon.enable = false;

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
