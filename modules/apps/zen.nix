{ inputs, ... }:
{
  den.aspects.apps._.zen.homeManager = {
    imports = [ inputs.zen-browser.homeModules.default ];
    programs.zen-browser.enable = true;
    home.sessionVariables.BROWSER = "zen";
  };
}
