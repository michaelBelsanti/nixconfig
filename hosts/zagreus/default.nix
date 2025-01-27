{ delib, pkgs, inputs, ... }:
delib.host {
  name = "zagreus";
  rice = "catppuccin";
  type = "laptop";

  displays = [
    {
      name = "eDP-1";
      refreshrate = 60;
      width = 2256;
      height = 1504;
      scaling = 1.75;
    }
  ];

  myconfig = {
    desktops.cosmic.enable = true;
    gaming.enable = true;
    services.tailscale.remote = true;
  };

  nixos = {
    imports = with inputs; [
      nixos-hardware.nixosModules.framework-13-7040-amd
      lanzaboote.nixosModules.lanzaboote
    ];

    networking.hostName = "zagreus"; # Define your hostname.

    hardware.framework.enableKmod = false;

    boot.kernelParams = [ "acpi_backlight=native" ];

    services = {
      btrfs.autoScrub.enable = true;
      libinput = {
        mouse = {
          accelProfile = "flat";
          middleEmulation = false;
          additionalOptions = ''
            Option "MiddleEmulation" "off"
          '';
        };
        touchpad = {
          accelProfile = "adaptive";
        };
      };
      fprintd.enable = false; # Enable fingerprint scanner
      fwupd = {
        enable = true; # Enable firmware updates with `fwupdmgr update`
        # extraRemotes = [ "lvfs-testing" ];
      };
    };
  };
}
