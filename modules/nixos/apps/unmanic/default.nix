{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.apps.unmanic;
in
{
  options.apps.unmanic.enable = mkBoolOpt false "Enables unmanic container";

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      unmanic = {
        image = "josh5/unmanic";
        ports = [ "8888:8888" ];
        volumes = [
          "/var/lib/unmanic:/config"
        ];
      };
    };
  };
}

