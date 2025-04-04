{
  unify,
  lib,
  pkgs,
  constants,
  host,
  ...
}:
unify.module {
  name = "virtualisation";
  options.virtualisation = {
    enable = unify.boolOption host.isWorkstation;
    waydroid.enable = unify.boolOption false;
  };
  nixos.ifEnabled =
    { cfg, ... }:
    {
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
    };
  nixos.always.virtualisation.vmVariant = {
    services.btrfs.autoScrub.enable = lib.mkForce false;
    virtualisation = {
      qemu.guestAgent.enable = true;
      memorySize = 6144;
      diskSize = 10240;
      cores = 4;
    };
  };
}
