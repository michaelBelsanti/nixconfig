{
  styx.nixos =
    { lib, ... }:
    {
      virtualisation.vmVariant = {
        services.btrfs.autoScrub.enable = lib.mkForce false;
        virtualisation = {
          qemu.guestAgent.enable = true;
          memorySize = 6144;
          diskSize = 10240;
          cores = 4;
        };
      };
    };
}
