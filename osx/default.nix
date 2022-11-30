{ lib, pkgsForSystem, inputs, home-manager, darwin, ...}:
let
  user = "michaelbelsanti";
  system = "aarch64-darwin";
  pkgs = pkgsForSystem system;
in
{
  osx = darwin.lib.darwinSystem {
    inherit system pkgs;
    specialArgs = { inherit inputs user; };
    modules = [
      ./configuration.nix
      ../packages/osx
      
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users."${user}" = import ./home.nix;
      }
    ];
  };
}