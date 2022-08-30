# Imported by hosts/desktop/configuration.nix
# Allows kvms and pcie passthrough

{ lib, config, pkgs, ...}:
{
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" "vfio_pci" ];
  boot.kernelModules = [ "kvm-amd" "vfio-pci" ];
  boot.extraModprobeConfig = "options kvm_amd nested=1\n";
  users.users.quasi.extraGroups = [ "libvirtd" ];
  
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        runAsRoot = true;
        ovmf.enable = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    virt-manager
    libguestfs # needed to virt-sparsify qcow2 files
  ];
  
  # Add binaries to path so that hooks can use it
  systemd.services.libvirtd = {
    path = let
         env = pkgs.buildEnv {
             name = "qemu-hook-env";
             paths = with pkgs; [
               bash
               libvirt
               kmod
               systemd
               ripgrep
               sd
             ];
           };
       in
         [ env ];
  };
 
  environment.etc = {
    "libvirt/hooks/kvm.conf".source = ./hooks/kvm.conf;
    "libvirt/hooks/qemu".source = ./hooks/qemu;
    "libvirt/hooks/qemu.d/win10/prepare/begin/start.sh".source = ./hooks/start.sh;
    "libvirt/hooks/qemu.d/win10/release/end/revert.sh".source = ./hooks/revert.sh;
  };
  
  # Link hooks to the correct directory
  system.activationScripts.libvirt-hooks.text =
  ''
    ln -Tfs /etc/libvirt/hooks /var/lib/libvirt/hooks
  '';
}