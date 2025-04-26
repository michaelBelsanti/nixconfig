{
  mylib,
  lib,
  pkgs,
  constants,
  host,
  config,
  ...
}:
let
  cfg = config.virtualisation;
in
{
  options.virtualisation = {
    enable = mylib.boolOption host.isWorkstation;
    waydroid.enable = mylib.boolOption false;
  };
  config.nixos = lib.mkMerge [
    (lib.mkIf cfg.enable {
      boot.kernelParams = [ "amd_iommu=on" ];
      users.users.${constants.username}.extraGroups = [ "kvm" ];
      programs.virt-manager.enable = true;
      environment.systemPackages = with pkgs; [
        gnome-boxes
        virglrenderer
      ];
      services.qemuGuest.enable = true;
      virtualisation = {
        waydroid.enable = cfg.waydroid.enable;
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
        podman.enable = true;
      };
    })
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
    }
  ];
}
