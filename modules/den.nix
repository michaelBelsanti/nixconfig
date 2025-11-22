{ inputs, den, ... }:
{
  imports = [
    inputs.den.flakeModule
    (inputs.den.namespace "styx" true)
  ];
  _module.args.__findFile = den.lib.__findFile;
  den.hosts.x86_64-linux.hades.users.quasi = { };
  den.hosts.x86_64-linux.zagreus.users.quasi = { };
}
