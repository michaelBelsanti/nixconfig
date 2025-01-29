{ delib, pkgs, ...}:
delib.module {
  name = "nixos";
  nixos.always = {
    environment.binsh = "${pkgs.dash}/bin/dash";
    zramSwap.enable = true;
  };
}
