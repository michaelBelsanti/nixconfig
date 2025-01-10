{
  delib,
  config,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "hades";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "22.05";

  nixos = {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

    fileSystems."/run/media/quasi/hdd" = {
      device = "/dev/disk/by-label/mainhdd";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "async"
      ];
    };

    swapDevices = [ ];

    networking.useDHCP = lib.mkDefault true;
    networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
