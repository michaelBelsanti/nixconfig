{
  styx.udev.nixos =
    { pkgs, ... }:
    {
      services.udev = {
        packages = [
          (pkgs.writeTextFile {
            name = "my-rules";
            text = ''
              SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", TAG+="uaccess"
            '';
            destination = "/etc/udev/rules.d/50-beast-miao.rules";
          })
        ];
        extraRules = ''
          ENV{ID_VENDOR_ID}=="248a", ENV{ID_MODEL_ID}=="8589", ENV{LIBINPUT_CALIBRATION_MATRIX}="0.5 0 0 0 0.5 0 0 0 1"
        '';
      };
    };
}
