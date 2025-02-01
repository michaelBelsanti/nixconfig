{
  delib,
  pkgs,
  inputs,
  constants,
  lib,
  ...
}:
delib.host {
  name = "hermes";
  rice = "catppuccin";
  type = "laptop"; # close enough

  displays = [
    {
      name = "DP-1";
      primary = true;
      refreshrate = 240;
      width = 1920;
      height = 1080;
    }
    {
      name = "HDMI-A-1";
      primary = false;
      refreshrate = 60;
      width = 1920;
      height = 1080;
      x = -1920;
    }
  ];

  myconfig = {
    desktops.cosmic.enable = true;
    packages.cli.enable = false;
    programs.scrobbler.enable = false;
    gaming.enable = true;
  };

  nixos = {
    imports = with inputs; [ jovian.nixosModules.default ];
    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        desktopSession = "cosmic";
        user = "${constants.username}";
      };
      decky-loader.enable = true;
      devices.steamdeck.enable = true;
      devices.steamdeck.enableGyroDsuService = true;
      hardware.has.amd.gpu = true;
    };

    services = {
      displayManager.cosmic-greeter.enable = lib.mkForce false;
      btrfs.autoScrub.enable = true;
      openssh = {
        enable = true;
        ports = [ 42069 ];
        settings.PasswordAuthentication = false;
      };
    };
  };
}
