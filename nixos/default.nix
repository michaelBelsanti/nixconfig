# Main universal NixOS configuration, imported by all NixOS configs.

{ pkgs, user, flakePath, ... }:
{
  imports = [ ./nix.nix ];

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ nushell zsh ];
  };

  # Boot options
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet" "splash" "vt.global_cursor_default=0"
      "transparent_hugepage=always" "default_hugepagez=1G" "hugepagesz=1G"
    ];
    tmpOnTmpfs = true;
    # Cute boot animation
    plymouth.enable = true;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
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

  # Xserver input
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    layout = "us";
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
    bluetooth.enable = true; # Enable bluetooth
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
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    mullvad-vpn.enable = true;
    qemuGuest.enable = true;
    gvfs.enable = true;
    input-remapper.enable = true;
  };

  programs = {
    zsh.enable = true;
    kdeconnect.enable = true;
    dconf.enable = true;
    ssh.startAgent = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
    };
    nix-ld.enable = true;
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
    vmVariant.virtualisation = {
      memorySize = 4096;
      cores = 4;
    };
  };

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [{
      users = [ "${user}" ];
      keepEnv = true;
      persist = true;
    }];
    polkit.enable = true;
    pam.enableSSHAgentAuth = true;
  };

  system.activationScripts.registryAdd.text = ''
    ${pkgs.nix}/bin/nix registry add nixconfig ${flakePath}
  '';

  system.stateVersion = "22.05"; # Did you read the comment?
}
