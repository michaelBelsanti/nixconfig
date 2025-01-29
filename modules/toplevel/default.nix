{ delib, pkgs, inputs, ...}:
delib.module {
  name = "nixos";
  nixos.always = {
    imports = with inputs; [ flake-programs-sqlite.nixosModules.programs-sqlite ];
    environment.binsh = "${pkgs.dash}/bin/dash";
    zramSwap.enable = true;
  };
}
