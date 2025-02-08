{
  delib,
  lib,
  pkgs,
  constants,
  ...
}:
delib.module {
  name = "virtualisation";
  options = delib.singleEnableOption true;
  nixos.ifEnabled = {
    users.users.${constants.username}.extraGroups = [ "kvm" ];
    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-boxes
      virglrenderer
    ];
    services.qemuGuest.enable = true;
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
  };
}
