{
  mylib,
  lib,
  host,
  ...
}:
{
  args.mylib = {
    mkOption = type: default: lib.mkOption { inherit type default; };
    mkBool = default: lib.mkOption lib.types.bool default;
    mkEnabledIf = tag: mylib.mkOption lib.types.bool (host.is tag);
  };
}
