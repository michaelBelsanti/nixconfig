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
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

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

    swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
    # networking.interfaces.vethpE87wO.useDHCP = lib.mkDefault true;
    # networking.interfaces.waydroid0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
