{ delib, inputs, host, pkgs, ...}:
delib.module {
  name = "programs.zen";
  options = delib.singleEnableOption (!host.isServer);
  nixos.ifEnabled.environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.system}.twilight
  ];
  home.ifEnabled.home.sessionVariables.BROWSER = "zen";
}
