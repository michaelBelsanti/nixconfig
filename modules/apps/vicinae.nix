{ inputs, ... }:
{
  den.aspects.apps._.vicinae.homeManager = {
    imports = [ inputs.vicinae.homeManagerModules.default ];
    xdg.configFile."vicinae/vicinae.json".enable = false;
    services.vicinae = {
      enable = true;
      useLayerShell = false;
    };
  };
}
