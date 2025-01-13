{ delib, inputs, host, pkgs, ...}:
delib.module {
  name = "programs.zen";
  options = delib.singleEnableOption (!host.isServer);
  nixos.ifEnabled.environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.system}.zen-browser
  ];
  home.ifEnabled.home.sessionVariables.BROWSER = "zen";
}
