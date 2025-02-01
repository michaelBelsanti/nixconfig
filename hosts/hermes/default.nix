{ delib, pkgs, inputs, ... }:
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

    

    services = {
      btrfs.autoScrub.enable = true;
      xserver.videoDrivers = [ "amdgpu" ];
      libinput.mouse = {
        accelProfile = "flat";
        middleEmulation = false;
      };
      openssh = {
        enable = true;
        ports = [ 42069 ];
        settings.PasswordAuthentication = false;
      };
    };
  };
}
