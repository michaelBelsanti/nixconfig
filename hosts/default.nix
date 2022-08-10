{ lib, inputs, nixpkgs, nixos-hardware, home-manager, user, hyprland, protocol, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user protocol; };
    modules = [ 
      ./main
      ./desktop
        
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user}= {
          imports = [ 
            ./main/user/home.nix
            #./desktop/user/home.nix
          ];
        };
      }
    ];
  };

  framework = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user protocol hyprland; };
    modules = [ 
      ./main
      ./framework
        
      hyprland.nixosModules.default

      nixos-hardware.nixosModules.framework
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = {
          imports = [ 
            ./main/user/home.nix
            #./framework/user/home.nix
          ];
        };
      }
    ];
  };
     
}
