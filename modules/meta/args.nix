{ lib, config, ... }:
let
  inherit (lib) types mkOption;
in
{
  options.args = mkOption {
    type = types.lazyAttrsOf types.unspecified;
    default = { };
  };
  config = {
    _module.args = config.args;
    unify.nixos._module.args = config.args;
    unify.home._module.args = config.args;
  };
}
