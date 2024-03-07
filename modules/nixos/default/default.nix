# Main universal NixOS configuration, imported by all NixOS configs.
{
  pkgs,
  lib,
  flakePath,
  inputs,
  config,
  ...
}:
{
  users.mainUser = "quasi";

  snowfallorg.user.${config.users.mainUser}.home.config = {
    # Main user theming
    # services.nextcloud-client.enable = true;
    home.stateVersion = "22.05";
    apps = {
      foot.enable = true;
    };
    theming = {
      enable = true;
      theme = "catppuccin";
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
      gtk2.configLocation = "${
        config.snowfallorg.user.${config.users.mainUser}.home.config.xdg.configHome
      }/gtk-2.0/gtkrc";
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
  };

  # Boot options
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = {
      "transparent_hugepage" = "always";
      "vm.nr_hugepages_defrag" = 0;
      "ipcs_shm" = 1;
      "default_hugepagez" = "1G";
      "hugepagesz" = "1G";
      "vm.swappiness" = 1;
      "vm.compact_memory" = 0;
      "vm.max_map_count" = 2097152;
    };
    tmp.useTmpfs = false;
    # Cute boot animation
    loader = {
      systemd-boot = {
        enable = true;
        netbootxyz.enable = true;
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    supportedFilesystems = [ "ntfs" ]; # Adds NTFS driver
    # Allow appimages to be run directly
    binfmt.registrations.appimage =
      let
        slippi-pkgs = inputs.nixpkgs-slippi-fix.legacyPackages.${pkgs.system};
      in
      {
        wrapInterpreterInShell = false;
        interpreter = "${slippi-pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
        magicOrExtension = "\\x7fELF....AI\\x02";
      };
  };

  # These units regularly causes problems
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  # Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Xserver input
  services.xserver = {
    enable = true;
    libinput.enable = true;
    desktopManager.wallpaper.mode = "fill";
    # Wayland
    desktopManager.plasma5.useQtScaling = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.gdm.wayland = true;
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
  users.users.${config.users.mainUser} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "lp"
      "scanner"
    ];
    initialPassword = "lol";
    shell = pkgs.fish;
  };

  # Best fonts (Especially JetBrains Mono)
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      montserrat
      twemoji-color-font
      libertine
    ];
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Montserrat" ];
      monospace = [ "JetBrainsMono NF" ];
      emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
    };
  };

  # Environment
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [
      fish
      nushell
      ion
    ];
    defaultPackages = with pkgs; [
      micro
      git
      perl
      rsync
      strace
    ];
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "kate";
      WINEDLLOVERRIDES = "winemenubuilder.exe=d";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };

  ### Services and hardware ###

  # Others (things that for some reason aren't in services, hardware, or programs)
  appstream.enable = true;
  zramSwap.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "*";
  };

  # Services
  services = {
    openssh = {
      settings = {
        X11Forwarding = false;
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        UseDns = false;
        StreamLocalBindUnlink = true;
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
          "sntrup761x25519-sha512@openssh.com"
        ];
      };
    };
    espanso.enable = true;
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
      drivers = [ pkgs.hplip ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
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
    # system76-scheduler.enable = true;
  };

  programs = {
    firefox = {
      enable = false;
      package = pkgs.firefox-bin;
      policies = {
        DisableAppUpdate = true;
      };
      preferences =
        let
          enableAndSync =
            prefs:
            lib.attrsets.genAttrs (map (name: "services.sync.prefs.sync." + name) (builtins.attrNames prefs)) (
              _: true
            )
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
    ssh = {
      startAgent = true;
      # well known hosts
      knownHosts = {
        "github.com".hostNames = [ "github.com" ];
        "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

        "gitlab.com".hostNames = [ "gitlab.com" ];
        "gitlab.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";

        "git.sr.ht".hostNames = [ "git.sr.ht" ];
        "git.sr.ht".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
      };
    };
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
  environment.systemPackages = with pkgs; [
    boxes
    virt-manager
    virglrenderer
  ];
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
        users = [ "${config.users.mainUser}" ];
        keepEnv = true;
        persist = true;
      }
    ];
    polkit.enable = true;
  };

  system.activationScripts = {
    diff = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "--- diff to current-system"
          ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
          echo "---"
        fi
      '';
    };
    registryAdd.text = ''
      ${pkgs.nix}/bin/nix registry add nixconfig ${flakePath}
    '';
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
