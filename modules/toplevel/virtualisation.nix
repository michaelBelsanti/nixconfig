{ lib, constants, ... }:
{
  unify = {
    modules.virtualisation.nixos =
      { pkgs, ... }:
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
          libvirtd.enable = true;
          spiceUSBRedirection.enable = true;
          podman.enable = true;
        };
      };
    modules.waydroid.nixos.virtualisation.waydroid.enable = true;
    nixos = {
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
  };
}
