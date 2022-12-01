# Contains all my NixOS configurations and their imports

{ lib, pkgsFor, user, flakePath, inputs, home-manager, ... }:
let
  system = "x86_64-linux";
  pkgs = pkgsFor system;
in
{
  desktop = lib.nixosSystem {
    inherit system pkgs;
    specialArgs = { inherit inputs user flakePath; };
    modules = [
      ./configuration.nix
      ./desktop/configuration.nix
      ../packages/nixos/desktop


      inputs.hyprland.nixosModules.default

      inputs.nix-gaming.nixosModules.pipewireLowLatency

      inputs.nixos-hardware.nixosModules.common-cpu-amd
      inputs.nixos-hardware.nixosModules.common-pc-ssd

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user flakePath; };
        home-manager.users.${user} = {
          imports = [
            ./desktop/home.nix
            inputs.spicetify-nix.homeManagerModule
          ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user flakePath; };
    modules = [
      ./configuration.nix
      ./laptop/configuration.nix
      ../packages/nixos/laptop

      inputs.hyprland.nixosModules.default

      inputs.nixos-hardware.nixosModules.framework-12th-gen-intel

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user flakePath; };
        home-manager.users.${user} = {
          imports = [
            ./laptop/home.nix
            inputs.hyprland.homeManagerModules.default
          ];
        };
      }
    ];
  };

}
