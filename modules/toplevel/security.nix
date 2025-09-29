{ lib, ... }:
{
  unify.nixos.security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
    polkit.enable = true;
    pam = {
      services.systemd-run0 = { };
      loginLimits = lib.singleton {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "unlimited";
      };
    };
  };
}
