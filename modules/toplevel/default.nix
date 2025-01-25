{ delib, pkgs, inputs, ...}:
delib.module {
  name = "nixos";
  nixos.always = {
    imports = with inputs; [ flake-programs-sqlite.nixosModules.programs-sqlite ];
    system.stateVersion = "22.05";
    environment.binsh = "${pkgs.dash}/bin/dash";
    zramSwap.enable = true;
  };
}
