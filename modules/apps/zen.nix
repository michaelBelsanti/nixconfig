{ inputs, ... }:
{
  styx.apps._.zen.homeManager = {
    imports = [ inputs.zen-browser.homeModules.default ];
    programs.zen-browser.enable = true;
    programs.zen-browser.suppressXdgMigrationWarning = true;
    home.sessionVariables.BROWSER = "zen";
  };
}
