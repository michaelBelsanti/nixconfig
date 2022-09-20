# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, user, ... }:
let catppuccin-grub-theme = pkgs.fetchFromGitHub
  {
    owner = "catppuccin";
    repo = "grub";
    rev = "fc5fba2896db095aee7b0d6442307c3035a24fa7";
    sparseCheckout = "src";
    sha256 = "sha256-MnIhLcI+1QEnkWzJ9Z5viANezKIv+hvw07+JYYtBzAE=";
  };
in
{
  imports = 
    [
      ./nix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "splash" "vt.global_cursor_default=0" ];
    tmpOnTmpfs = true;
    # Cute boot animation
    plymouth.enable = true;
    loader = {
      # systemd-boot.enable = true;
      grub = {
        enable = true;
        # theme = "${catppuccin-grub-theme}/catppuccin-mocha-grub-theme/theme.txt";
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
      # systemd-boot.configurationLimit = 3; # 3 generations maximum on boot screen
    };
    supportedFilesystems = [ "ntfs" ];
  };

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
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
    jack.enable = true;
  };

  # XDG Desktop Portal
  xdg = {
    portal = {
      enable = true;
      # Fails to build when gnome
      extraPortals = with pkgs; [
        # xdg-desktop-portal-gtk
      ];
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
  
  # Best fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    montserrat
  ];
  
  # Environment variables
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  ### Services and hardware ###
  # Framework stuff
  hardware.bluetooth.enable = true; # Enable bluetooth (duh)

  services.xserver.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      middleEmulation = false;
    };
    touchpad = {
      accelProfile = "adaptive";
    };
  };

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
  
  # Other services
  services = {
    mullvad-vpn.enable = true;
    greenclip.enable = true;
  };


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
