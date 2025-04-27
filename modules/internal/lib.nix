{
  mylib,
  lib,
  host,
  hostname,
  config,
  ...
}:
{
  args = {
    host.is = tag: lib.lists.elem tag config.host.${hostname}.tags;
    mylib = {
      mkOption = type: default: lib.mkOption { inherit type default; };
      mkBool = default: mylib.mkOption lib.types.bool default;
      mkEnabledIf = tag: mylib.mkOption lib.types.bool (host.is tag);
    };
  };
}
