{
  delib,
  constants,
  lib,
  ...
}:
delib.module {
  name = "security";
  options.security.doas.enable = delib.boolOption false;
  nixos.always =
    { cfg, ... }:
    {
      security = {
        sudo.enable = !cfg.doas.enable;
        doas.enable = cfg.doas.enable;
        doas.extraRules = lib.mkIf cfg.doas.enable [
          {
            users = [ "${constants.username}" ];
            keepEnv = true;
            persist = true;
          }
        ];
        polkit.enable = true;
        pam.loginLimits = [
          {
            domain = "*";
            type = "soft";
            item = "nofile";
            value = "8192";
          }
        ];
      };
    };
}
