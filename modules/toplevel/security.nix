{
  den.default.nixos.security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
    polkit.enable = true;
    pam = {
      services.systemd-run0 = { };
      loginLimits = [
        {
          domain = "*";
          item = "nofile";
          type = "hard";
          value = 128000;
        }
        {
          domain = "*";
          item = "nofile";
          type = "soft";
          value = 20480;
        }
      ];
    };
  };
}
