{ den, ... }:
{
  den.aspects.quasi.includes = [ den.provides.primary-user ];
  den.hosts.x86_64-linux.hades.users.quasi = { };
  den.hosts.x86_64-linux.zagreus.users.quasi = { };
}
