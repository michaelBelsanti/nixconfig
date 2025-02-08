{ delib, pkgs, host, homeConfig, ...}:
delib.module {
  name = "toplevel";
  nixos.always = {
    environment = {
      binsh = "${pkgs.dash}/bin/dash";
      enableAllTerminfo = host.isServer;
      # fixes some issues, mainly root $PATH
      systemPackages = homeConfig.home.packages;
    };
    zramSwap.enable = true;
  };
}
