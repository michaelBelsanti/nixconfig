{
  unify.hosts.nixos.hades = {
    nixos = {
      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "btrfs";
        options = [ "compress=zstd" "noatime" ];
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "noatime" ];
      };
      services = {
        btrfs.autoScrub.enable = true;
        beesd.filesystems.nixroot = {
          spec = "LABEL=NIXROOT";
          hashTableSizeMB = 256;
          verbosity = "crit";
          extraOptions = [
            "--loadavg-target"
            "2.0"
          ];
        };
      };
    };
  };
}
