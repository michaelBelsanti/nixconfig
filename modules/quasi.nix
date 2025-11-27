{ den, __findFile, ... }:
{
  den.aspects.quasi = {
    includes = [
      <den/primary-user>
      <styx/helix/with-tools>
      <styx/nushell>
      <styx/shell>
    ];
    nixos.users.users.quasi.extraGroups = [
      "adb"
      "docker"
      "wireshark"
    ];
  };
  den.hosts.x86_64-linux.hades.users.quasi = { };
  den.hosts.x86_64-linux.zagreus.users.quasi = { };
}
