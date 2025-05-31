{ lib, ... }:
{
  unify.nixos.security = {
    polkit.enable = true;
    pam.services.systemd-run0 = {};
    pam.loginLimits = lib.singleton {
      domain = "*";
      item = "nofile";
      type = "-";
      value = "20480";
    };
  };
}
