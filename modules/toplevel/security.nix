{ lib, ... }:
{
  unify.nixos.security = {
    polkit.enable = true;
    pam.loginLimits = lib.singleton {
      domain = "*";
      item = "nofile";
      type = "-";
      value = "20480";
    };
  };
}
