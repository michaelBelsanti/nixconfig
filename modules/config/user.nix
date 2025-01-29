{ delib, constants, ... }:
delib.module {
  name = "user";

  nixos.always = {
    users = {
      groups.${constants.username} = { };

      users.${constants.username} = {
        isNormalUser = true;
        initialPassword = constants.username;
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
