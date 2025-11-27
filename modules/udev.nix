{
  # lowest DPI of vertical mouse is 1200 for some reason
  styx.udev.nixos.services.udev.extraRules = ''
    ENV{ID_VENDOR_ID}=="248a", ENV{ID_MODEL_ID}=="8589", ENV{LIBINPUT_CALIBRATION_MATRIX}="0.5 0 0 0 0.5 0 0 0 1"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", TAG+="uaccess"
  '';
}
