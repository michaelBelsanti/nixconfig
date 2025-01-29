{ delib, constants, ... }:
delib.module {
  name = "security";
  nixos.always =
    {
      security = {
        sudo.enable = false;
        doas.enable = true;
        doas.extraRules = [
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
