{
  delib,
  config,
  lib,
  modulesPath,
  ...
}:
delib.host {
  name = "nyx";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "22.05";

  nixos = {
    system.stateVersion = "22.05";

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/d43a8ea4-3f83-4455-bf66-ad13600ea6d7";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-uuid/4A59-A124";
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
    # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.podman0.useDHCP = lib.mkDefault true;
    # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
    # networking.interfaces.ve-transmission.useDHCP = lib.mkDefault true;
    # networking.interfaces.veth0.useDHCP = lib.mkDefault true;
    # networking.interfaces.veth1.useDHCP = lib.mkDefault true;
    # networking.interfaces.veth2.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
