{ lib, inputs, nixpkgs, nix-gaming, nixos-hardware, home-manager, user, hyprland, ... }:

let
  system = "x86_64-linux";
  user = "quasi";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user hyprland; };
    modules = [ 
      ./configuration.nix
      ./desktop/configuration.nix
        
      hyprland.nixosModules.default
      
      nix-gaming.nixosModules.pipewireLowLatency 
        
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-pc-ssd
      
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user}= {
          imports = [ 
            ./desktop/home.nix
          ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user hyprland; };
    modules = [ 
      ./configuration.nix
      ./laptop/configuration.nix
        
      hyprland.nixosModules.default

      nixos-hardware.nixosModules.framework-12th-gen-intel

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [ 
            ./laptop/home.nix
          ];
        };
      }
    ];
  };
     
}
