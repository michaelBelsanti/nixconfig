{ delib, inputs, ... }:
delib.module {
  name = "programs.nix-index-db";
  nixos.always = {
    imports = [ inputs.nix-index-database.nixosModules.nix-index ];
    programs.nix-index-database.comma.enable = true;
  };
  home.always = {
    imports = [ inputs.nix-index-database.hmModules.nix-index ];
    programs.nix-index-database.comma.enable = true;
  };
}
