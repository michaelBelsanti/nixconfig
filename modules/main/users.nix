{ constants, host, ... }:
{
  nixos.users = {
    groups.${constants.user} = { };
    users.${constants.user} = {
      isNormalUser = true;
      initialPassword = constants.user;
      linger = host.is "server";
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

}
