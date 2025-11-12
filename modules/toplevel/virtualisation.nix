{den,...}:
{
  den.aspects.virt.provides = {
    qemu = {
      # includes = [ den.aspects.virt._.qemu._.group ];
      # provides.group =
      #   { user, ... }:
      #   {
      #     nixos.users.users.${user.userName}.extraGroups = [ "kvm" ];
      #   };
      nixos =
        { pkgs, ... }:
        {
          users.users.quasi.extraGroups = [ "kvm" ];
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
