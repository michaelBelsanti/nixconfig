{
  delib,
  config,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "zagreus";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "22.05";

  nixos = {
    system.stateVersion = "22.05";
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/c3fde0b2-d7da-4109-b4cb-27c7a2e53e4b";
      fsType = "btrfs";
      options = [ "subvol=nixos" ];
    };

    boot.initrd.luks.devices."nixroot".device =
      "/dev/disk/by-uuid/02eca0c6-bf0c-4bbb-93c7-687719bbf1fa";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/0001-9657";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };
}
