# Main universal NixOS configuration, imported by all NixOS configs.

{ pkgs, user, flakePath, ... }:
let
  catppuccin-grub-theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "fc5fba2896db095aee7b0d6442307c3035a24fa7";
    sparseCheckout = [ "src/catppuccin-mocha-grub-theme" ];
    sha256 = "sha256-ePhMQLn39fuEvT097XvjugWKqHivXhZPbqsD+LBXOwE=";
  };
in
{
  imports = [ ./nix.nix ];

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ nushell zsh ];
    systemPackages = [ catppuccin-grub-theme ];
  };

  # Boot options
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
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
        splashImage =
          "${catppuccin-grub-theme}/src/catppuccin-mocha-grub-theme/background.png";
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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true;
  # };

  # Xserver input
  services.xserver = {
    desktopManager.plasma5.enable = true;
    layout = "us";
    libinput.enable = true;
    desktopManager.gnome.extraGSettingsOverrides = ''
      [com.ubuntu.login-screen]
      background-color='#1e1e2e'
    '';
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
    shell = pkgs.nushell;
  };

  # Best fonts (Especially JetBrains Mono)
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      montserrat
      eb-garamond
      twemoji-color-font
    ];
    enableDefaultFonts = true;
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      serif = [ "EB Garamond" ];
      sansSerif = [ "Montserrat" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
    };
  };

  # qt5 = {
  #   platformTheme = "qt5ct";
  #   style = "Lightly";
  # };

  # Environment variables
  environment = {
    defaultPackages = with pkgs; [ micro git perl rsync strace ];
    variables = {
      EDITOR = "micro";
      VISUAL = "kate";
      __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
    };
  };

  ### Services and hardware ###

  # Others (things that for some reason aren't in services, hardware, or programs)
  appstream.enable = true;
  zramSwap.enable = true;
  xdg.portal.enable = true;

  # Services
  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
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
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=10s
    DefaultTimeoutStopSec=10s
    DefaultTimeoutAbortSec=10s
    DefaultDeviceTimeoutSec=10s
  '';

  # VMs
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    podman.enable = true;
    # For running a nixos-vm
    vmVariant.virtualisation = {
      memorySize = 4096;
      cores = 4;
    };
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

  system.activationScripts.registryAdd.text = ''
    ${pkgs.nix}/bin/nix registry add nixconfig ${flakePath}
  '';

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
