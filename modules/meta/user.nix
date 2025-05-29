{ lib,...}:
{
  unify.options.primaryUser = lib.mkOption {
    type = lib.types.str;
    default = "quasi";
  };
}
