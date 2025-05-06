{ constants, ... }:
{
  unify = {
    modules.server.nixos.users.users.${constants.user}.linger = true;
    nixos = {
      users = {
        groups.${constants.user} = { };
        users.${constants.user} = {
          isNormalUser = true;
          initialPassword = constants.user;
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
  };
}
