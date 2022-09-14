{ lib, inputs, nixpkgs, home-manager, darwin, user, ...}:
let
  system = "aarch64-darwin";
  user = "michaelbelsanti";
in
{
  osx = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./configuration.nix
      
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users."${user}" = import ./home.nix;
      }
    ];
  };
}