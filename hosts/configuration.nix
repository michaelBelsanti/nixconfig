# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, user, ... }:
{
  imports = 
    [
      ../packages/system.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelParams = [ "quiet" "splash" "vt.global_cursor_default=0" ];
    tmpOnTmpfs = true;
    # Cute boot animation
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
      systemd-boot.configurationLimit = 3; # 3 generations maximum on boot screen
    };
  };

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  services.mullvad-vpn.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };
  
  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    touchpad.accelProfile = "flat";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "caps:escape"; # map caps to escape.

  # Enable CUPS to print documents.
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # Use pipewire
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # XDG Desktop Portal
  xdg = {
    portal = {
      enable = true;
      # Fails to build?
      # extraPortals = with pkgs; [
      #   xdg-desktop-portal-gtk
      # ];
    };
  };
  
  zramSwap.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user}= {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
    initialPassword = "lol";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  hardware.steam-hardware.enable = true;
  programs.steam.enable = true;
  
  # Environment variables
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  ### Services and hardware ###
  # Framework stuff
  hardware.bluetooth.enable = true; # Enable bluetooth (duh)

  # VMs
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  
  # Flatpaks
  services.flatpak.enable = true;
  services.packagekit.enable = true; # For guis such as GNOME Software
  appstream.enable = true;
  programs.dconf.enable = true;

  # Uniform qt theming
  qt5 = {
    enable = true;
    style = "gtk2";
    platformTheme = "gtk2";
  };
  environment.systemPackages = [pkgs.libsForQt5.qtstyleplugins ];

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [{
      users = [ "${user}" ];
      keepEnv = true;
      persist = true;
    }];
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  networking.firewall.enable = false;

  # Enable unfree repo
  nixpkgs.config.allowUnfree = true;
  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };
  nix.settings.auto-optimise-store = true;

  # system.autoupgrade = {
  #   enable = true;
  #   channel = "https://nixos.org/channels/nixos-unstable";
  # };

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
