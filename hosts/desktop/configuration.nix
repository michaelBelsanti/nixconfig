# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../packages/hosts/desktop
      ../../modules/vfio
      ../../modules/i3
    ];
  
  networking.hostName = "nix";
  networking.nameservers = [ "192.168.1.152" ];
  
  # Can't use 'max' cause shitty nvidia drivers
  boot.loader.systemd-boot.consoleMode = "keep";
  
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
  ];

  # Display shiz
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    screenSection = ''
          Option "metamodes" "DP-4: 1920x1080_240 +1920+0, HDMI-0: 1920x1080_60 +0+0"
      '';
    displayManager = {
      gdm.enable = true;
      gdm.wayland = false;
      # sessionCommands = "xrandr --output DP-4 --primary --mode 1920x1080 --rate 240 --output HDMI-0 --left-of DP-4";
    };
    desktopManager.gnome.enable = true;
  };
  services.gnome.chrome-gnome-shell.enable = true; # gnome extensions
    
  # VMs

  services.openssh = {
    enable = true;
    ports = [ 42069 ];
    banner = "You better be me. If you're not fuck off.\n";
    passwordAuthentication = false;
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
