{
  unify.modules.workstation.nixos =
    { hostConfig, ... }:
    {
      users.users.${hostConfig.primaryUser}.extraGroups = [ "adbusers" ];
      programs.adb.enable = true;
    };
}
