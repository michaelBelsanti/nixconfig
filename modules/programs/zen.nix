{ delib, inputs, host, pkgs, ...}:
delib.module {
  name = "programs.zen";
  options = delib.singleEnableOption host.hasGUI;
  nixos.ifEnabled.environment.systemPackages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
  home.ifEnabled = {
    home.packages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
    home.sessionVariables.BROWSER = "zen";
  };
}
