{ den, styx, ... }:
{
  styx.virt.provides = {
    qemu = den.lib.parametric {
      includes = [ (styx.groups "kvm") ];
      nixos =
        { pkgs, ... }:
        {
          boot.kernelParams = [ "amd_iommu=on" ];
          programs.virt-manager.enable = true;
          environment.systemPackages = with pkgs; [
            gnome-boxes
            virglrenderer
          ];
          services.qemuGuest.enable = true;
          virtualisation = {
            libvirtd.enable = true;
            spiceUSBRedirection.enable = true;
          };
        };
    };
    waydroid.nixos.virtualisation.waydroid.enable = true;
    podman.nixos.virtualisation.podman = {
      enable = true;
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
      };
    };
  };
}
