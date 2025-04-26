{
  mylib,
  constants,
  lib,
  config,
  ...
}:
{
  options.security.doas.enable = mylib.boolOption false;
  config.nixos =
    let
      doas = config.security.doas.enable;
    in
    {
      security = {
        sudo.enable = !doas;
        doas.enable = doas;
        doas.extraRules = lib.mkIf doas [
          {
            users = [ "${constants.user}" ];
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
