{ delib, inputs, host, pkgs, ...}:
delib.module {
  name = "programs.browser";
  options = delib.singleEnableOption (!host.isServer);
  system.ifEnabled.environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.system}.zen-browser
  ];
  home.ifEnabled.home.sessionVariables.BROWSER = "zen";
}
