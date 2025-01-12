{ delib, ... }:
delib.module {
  nixos.always =
    { myconfig, ... }:
    {
      security = {
        sudo.enable = false;
        doas.enable = true;
        doas.extraRules = [
          {
            users = [ "${myconfig.constans.username}" ];
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
