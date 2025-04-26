{
  username,
  host,
  ...
}:
{
  nixos.users = {
    groups.${username} = { };
    users.${username} = {
      isNormalUser = true;
      initialPassword = username;
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
