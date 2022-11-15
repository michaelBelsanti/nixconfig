{ lib, user, inputs, home-manager, darwin, devenv, ...}:
let
  system = "x86_64-darwin";
  user = "michaelbelsanti";
in
{
  osx = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs user devenv; };
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