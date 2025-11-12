{ den, ... }:
{
  den.aspects.quasi = {
    includes = [ den.provides.primary-user ];
    homeManager.services.ssh-agent.enable = true;
  };
  den.aspects.groups =
    { user, ... }:
    {
      nixos.users = {
        groups.${user.username} = { };
        users.${user.username} = {
          isNormalUser = true;
          initialPassword = user.username;
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
