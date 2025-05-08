{ inputs, ... }:
{
  unify.modules.workstation.home = {
    imports = [ inputs.zen-browser.homeModules.default ];
    programs.zen-browser.enable = true;
    home.sessionVariables.BROWSER = "zen";
  };
}
