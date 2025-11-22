{ den, styx, ... }:
{
  den.aspects.quasi = {
    includes = [
      den.provides.primary-user
      styx.groups
    ];
    homeManager.services.ssh-agent.enable = true;
  };
  styx.groups =
    { user, ... }:
    {
      nixos.users = {
        groups.${user.userName} = { };
        users.${user.userName} = {
          isNormalUser = true;
          initialPassword = user.userName;
          extraGroups = [
            "wheel"
            "video"
            "audio"
            "networkmanager"
            "lp"
            "scanner"
          ];
        };
      };
    };
}
