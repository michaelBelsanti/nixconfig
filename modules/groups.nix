{
  styx.groups =
    groups:
    { user, ... }:
    {
      nixos =
        { lib, ... }:
        {
          users.users.${user.userName}.extraGroups = lib.flatten [ groups ];
        };
    };
}
