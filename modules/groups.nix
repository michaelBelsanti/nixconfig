{ den, lib, ... }:
let
  groupsModule = groups: user: {
    nixos.users.users.${user.userName}.extraGroups = lib.flatten [ groups ];
  };
in
{
  styx.groups =
    groups:
    den.lib.parametric {
      includes = [
        ({ user, ... }: groupsModule groups user)
      ];
    };
}
