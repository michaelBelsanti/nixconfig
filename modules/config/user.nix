{
  delib,
  constants,
  host,
  ...
}:
delib.module {
  name = "user";

  nixos.always = {
    users = {
      groups.${constants.username} = { };

      users.${constants.username} = {
        isNormalUser = true;
        initialPassword = constants.username;
        linger = host.isServer;
        extraGroups = [
          "wheel"
          "video"
          "audio"
          "networkmanager"
          "lp"
          "scanner"
          "adbusers"
        ];
      };
    };
  };
}
