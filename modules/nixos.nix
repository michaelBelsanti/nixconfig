# Main universal NixOS configuration, imported by all NixOS configs.
{
  delib,
  pkgs,
  lib,
  inputs,
  ...
}:
delib.module {
  name = "nixos";
  home.always =
    { myconfig, ... }:
    {
      # Main user theming
      home.stateVersion = "22.05";
      xsession = {
        enable = true;
        initExtra = ''
          # xrdb merge ~/.config/X11/xresources
          ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
        '';
      };
      gtk = {
        enable = true;
        gtk2.configLocation = "${myconfig.constants.configHome}/gtk-2.0/gtkrc";
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
    };

  # Boot options
  nixos.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      imports = with inputs; [
        lix-module.nixosModules.default
        flake-programs-sqlite.nixosModules.programs-sqlite
        wrapper-manager.nixosModules.default
      ];
      boot = {
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
        loader = {
          efi.canTouchEfiVariables = true;
          timeout = 3;
        };
        supportedFilesystems = [ "ntfs" ]; # Adds NTFS driver
      };

      # These units regularly causes problems
      systemd.services.NetworkManager-wait-online.enable = false;
      systemd.network.wait-online.enable = false;

      # Locale
      time.timeZone = "America/New_York";
      i18n.defaultLocale = "en_US.UTF-8";

      # xserver
      services = {
        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];
        };
      };

      # Hardware settings
      hardware = {
        # Graphics
        graphics.enable = true;
        bluetooth.enable = true; # Enable bluetooth
      };

      # Environment
      xdg.terminal-exec.enable = true;
      environment = {
        binsh = "${pkgs.dash}/bin/dash";
        sessionVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
          WINEDLLOVERRIDES = "winemenubuilder.exe=d";
          FLAKE = "/home/${myconfig.constants.username}/.flake";
        };
      };

      ### Services and hardware ###
      # Others (things that for some reason aren't in services, hardware, or programs)
      appstream.enable = true;
      networking.wireguard.enable = true;
      zramSwap.enable = true;

      # Services
      services = {
        dbus.implementation = "broker";
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
        flatpak.enable = true;
        fstrim.enable = true;
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
        };
        qemuGuest.enable = true;
        gvfs.enable = true;
        input-remapper.enable = true;
        system76-scheduler.enable = true;
      };

      programs = {
        adb.enable = true;
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
        kdeconnect = {
          enable = false;
          package = pkgs.valent;
        };
        dconf.enable = true;
        ssh = {
          startAgent = true;
          # well known hosts
          knownHosts = {
            "github.com".hostNames = [ "github.com" ];
            "github.com".publicKey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

            "gitlab.com".hostNames = [ "gitlab.com" ];
            "gitlab.com".publicKey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";

            "git.sr.ht".hostNames = [ "git.sr.ht" ];
            "git.sr.ht".publicKey =
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
          };
        };
        mtr.enable = true;
        nix-ld.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
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
        gnome-boxes
        virglrenderer
      ];
      virtualisation = {
        waydroid.enable = true;
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

      system.stateVersion = "22.05"; # Did you read the comment?
    };
}
