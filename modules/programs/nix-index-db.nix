{ inputs, ... }:
{
  config = {
    nixos = {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];
      programs.nix-index-database.comma.enable = true;
    };
    home = {
      imports = [ inputs.nix-index-database.hmModules.nix-index ];
      programs.nix-index-database.comma.enable = true;
    };
  };
}
