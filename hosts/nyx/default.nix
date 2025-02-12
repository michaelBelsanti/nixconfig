{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.host {
  name = "nyx";
  # rice = "catppuccin";
  type = "server";

  homeManagerSystem = "x86_64-linux";

  shared.myconfig.services.syncthing.devices.nyx.id =
    "T7ES5DM-TIODWXE-T2LME4T-3RKTD6S-WFVTSVS-QHU5WEW-Q6GDROS-46H2AQZ";

  myconfig = {
    virtualisation.enable = false;
    packages.hacking.enable = false;
    zfs.pools = [ "zfsa" ];
  };

  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    imports = with inputs; [
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-gpu-intel
      nixos-hardware.nixosModules.common-pc-ssd
    ];
    # facter.reportPath = ./facter.json;
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
    hardware.intelgpu = {
      vaapiDriver = null;
      enableHybridCodec = true;
    };
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    networking = {
      hostId = "18190aed";
      defaultGateway = {
        address = "192.168.1.1";
        interface = "enp42s0";
      };
      nameservers = [ "1.1.1.1" ];
      interfaces.enp42s0.ipv4.addresses = [
        {
          address = "192.168.1.192";
          prefixLength = 24;
        }
      ];
      nat = {
        enable = true;
        internalInterfaces = [ "ve-+" ];
        externalInterface = "enp42s0";
      };
    };
  };
}
