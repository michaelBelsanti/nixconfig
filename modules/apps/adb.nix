{
  styx.apps.provides.adb =
    { user, ... }:
    {
      nixos = {
        users.users.${user.userName}.extraGroups = [ "adbusers" ];
        programs.adb.enable = true;
      };
    };
}
