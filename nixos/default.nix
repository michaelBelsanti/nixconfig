# Main universal NixOS configuration, imported by all NixOS configs.
{
  pkgs,
  lib,
  user,
  flakePath,
  ...
}: {
  imports = [./nix.nix];

  home-manager.users.${user} = {config, ...}: {
    # Main user theming
    # services.nextcloud-client.enable = true;
    theming = {
      enable = true;
      theme = "rosepine";
    };
    xsession = {
      enable = true;
      initExtra = ''
        # xrdb merge ~/.config/X11/xresources
        ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
      '';
    };
    gtk = {
      enable = true;
      font = {
        name = "Montserrat Semibold";
        package = pkgs.montserrat;
        size = 12;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk3 = {
        bookmarks = [
          "file:///home/quasi/Downloads Downloads"
          "file:///home/quasi/Documents Documents"
          "file:///home/quasi/Pictures Pictures"
          "file:///home/quasi/Videos Videos"
          "file:///home/quasi/Games Games"
        ];
      };
    };
    home.pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      x11.enable = true;
      gtk.enable = true;
    };
    programs.spicetify = {
      enable = true;
      enabledExtensions = with pkgs.spicePkgs.extensions; [fullAppDisplay featureShuffle hidePodcasts];
    };
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [fish nushell ion];
  };

  # Boot options
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernel.sysctl = {
      "transparent_hugepage" = "always";
      "vm.nr_hugepages_defrag" = 0;
      "ipcs_shm" = 1;
      "default_hugepagez" = "1G";
      "hugepagesz" = "1G";
      "vm.swappiness" = 1;
      "vm.compact_memory" = 0;
    };
    tmp.useTmpfs = true;
    # Cute boot animation
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    supportedFilesystems = ["ntfs"]; # Adds NTFS driver
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
    layout = "us";
    libinput.enable = true;
    desktopManager.wallpaper.mode = "fill";
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
    extraGroups = ["wheel" "video" "audio" "networkmanager" "lp" "scanner"];
    initialPassword = "lol";
    shell = pkgs.fish;
  };

  # Best fonts (Especially JetBrains Mono)
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      montserrat
      twemoji-color-font
    ];
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      serif = ["Liberation Serif"];
      sansSerif = ["Montserrat"];
      monospace = ["JetBrainsMono NF"];
      emoji = ["Twitter Color Emoji" "Noto Color Emoji"];
    };
  };

  # Environment variables
  environment = {
    defaultPackages = with pkgs; [micro git perl rsync strace];
    sessionVariables = {
      EDITOR = "micro";
      VISUAL = "kate";
      WINEDLLOVERRIDES = "winemenubuilder.exe=d";
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
    tailscale.enable = true;
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
      drivers = [pkgs.hplip];
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
    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
      policies = {
        DisableAppUpdate = true;
      };
      preferences = let
        enableAndSync = prefs:
          lib.attrsets.genAttrs
          (map (name:
            "services.sync.prefs.sync." + name)
          (builtins.attrNames prefs))
          (_: true)
          // prefs;
      in
        enableAndSync {
          "layout.spellcheckDefault" = 2;
          "extensions.pocket.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        };
    };
    fish = {
      enable = true;
      useBabelfish = true;
    };
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
    # command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
  };
  # systemd.extraConfig = ''
  #   DefaultTimeoutStartSec=10s
  #   DefaultTimeoutStopSec=10s
  #   DefaultTimeoutAbortSec=10s
  #   DefaultDeviceTimeoutSec=10s
  # '';
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # VMs
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    podman.enable = true;
    vmVariant = {
      services.btrfs.autoScrub.enable = lib.mkForce false;
      virtualisation = {
        qemu.guestAgent.enable = true;
        memorySize = 6144;
        diskSize = 10240;
        cores = 4;
      };
    };
  };

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [
      {
        users = ["${user}"];
        keepEnv = true;
        persist = true;
      }
    ];
    polkit.enable = true;
    pam.enableSSHAgentAuth = true;
  };

  system.activationScripts = {
    diff = {
      supportsDryActivation = true;
      text = ''
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
      '';
    };
    registryAdd.text = ''
      ${pkgs.nix}/bin/nix registry add nixconfig ${flakePath}
    '';
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
