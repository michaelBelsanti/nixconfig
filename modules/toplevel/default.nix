{ delib, pkgs, host, ...}:
delib.module {
  name = "nixos";
  nixos.always = {
    environment.binsh = "${pkgs.dash}/bin/dash";
    environment.enableAllTerminfo = host.isServer;
    zramSwap.enable = true;
  };
}
