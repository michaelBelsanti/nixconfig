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
      ./configuration.nix
      ./desktop/configuration.nix
        
      nixos-hardware.nixosModules.common-gpu-nvidia
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-pc-ssd
      
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user}= {
          imports = [ 
            ./home.nix
            ./desktop/home.nix
          ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user protocol hyprland; };
    modules = [ 
      ./configuration.nix
      ./laptop/configuration.nix
        
      hyprland.nixosModules.default

      nixos-hardware.nixosModules.framework

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user} = {
          imports = [ 
            ./home.nix
            ./laptop/home.nix
          ];
        };
      }
    ];
  };
     
}
