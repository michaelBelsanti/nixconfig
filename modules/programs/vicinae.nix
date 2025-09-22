{ inputs, ... }:
{
  unify.modules.workstation.home = {
    imports = [ inputs.vicinae.homeManagerModules.default ];
    services.vicinae = {
      enable = true;
      useLayerShell = false;
    };
  };
}
