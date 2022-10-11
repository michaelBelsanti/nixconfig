{ config, lib, pkgs, inputs, user, ... }:
let
catppuccin-grub-theme = pkgs.fetchFromGitHub
  {
    owner = "catppuccin";
    repo = "grub";
    rev = "fc5fba2896db095aee7b0d6442307c3035a24fa7";
    sparseCheckout = "src/catppuccin-mocha-grub-theme";
    sha256 = "sha256-ePhMQLn39fuEvT097XvjugWKqHivXhZPbqsD+LBXOwE=";
  };
in
{
  imports =
    [
      ./nix.nix
    ];

  environment.systemPackages = [
    catppuccin-grub-theme
  ];

  # Boot options
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [ "quiet" "splash" "vt.global_cursor_default=0" ];
    tmpOnTmpfs = true;
    # Cute boot animation
    plymouth.enable = true;
    loader = {
      # systemd-boot.enable = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        # Theming
        theme = "${catppuccin-grub-theme}/src/catppuccin-mocha-grub-theme";
        font = "${pkgs.montserrat}/share/fonts/otf/Montserrat-Regular.otf";
        fontSize = 48;
        splashImage = "${catppuccin-grub-theme}/src/catppuccin-mocha-grub-theme/background.png";
        backgroundColor = "#1E1E2E";
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    supportedFilesystems = [ "ntfs" ]; # Adds NTFS driver
  };

  networking = {
    networkmanager.enable = true;
    wireguard.enable = true;
  };

  # Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true;
  };

  # Xserver input
  services.xserver = {
    layout = "us";
    # xkbOptions = "caps:escape";
    libinput.enable = true;
  };

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # Hardware settings
  hardware = {
    # Graphics
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio.enable = false; # Disabled cause Pipewire exists
    bluetooth.enable = true; # Enable bluetooth (duh)
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
    initialPassword = "lol";
    shell = pkgs.zsh;
  };

  # Best fonts (Especially JetBrains Mono)
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    montserrat
  ];
  
  qt5 = {
    platformTheme = "qt5ct";
    style = "Lightly";
  };

  # Environment variables
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  ### Services and hardware ###

  # Others (things that for some reason aren't in services, hardware, or programs)
  appstream.enable = true;
  zramSwap.enable = true;
  xdg.portal.enable = true;

  # Services
  services = {
    flatpak.enable = true;

    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Printing
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

    # VPN
    mullvad-vpn.enable = true;

    # Clipboard daemon (for rofi clipboard)
    greenclip.enable = true;

    qemuGuest.enable = true;

    # Idk but thunar wants it
    gvfs.enable = true;
  };


  programs = {
  
    # I <3 Zsh
    zsh.enable = true; 
    
    # KDE Connect (mobile integration)
    kdeconnect.enable = true;

    # For flatpak
    dconf.enable = true;

    # Automatically add ssh-keys
    ssh.startAgent = true;

    # I don't know what this is, but I've had it enabled since my first install
    # (now I'm scared to disable it)
    mtr.enable = true;

    # Keys and stuff
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };
  };

  # VMs
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  # virtualisation.qemu.guestAgent.enable = true;

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [{
      users = [ "${user}" ];
      keepEnv = true;
      persist = true;
    }];
    polkit.enable = true;
    # For allowing SSH keys
    pam.enableSSHAgentAuth = true;
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
