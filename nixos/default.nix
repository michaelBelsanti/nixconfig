{ lib, system, user, inputs, home-manager, ... }:
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./configuration.nix
      ./desktop/configuration.nix


      inputs.hyprland.nixosModules.default

      inputs.nix-gaming.nixosModules.pipewireLowLatency

      inputs.nixos-hardware.nixosModules.common-cpu-amd
      inputs.nixos-hardware.nixosModules.common-pc-ssd

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [
            ./desktop/home.nix
          ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./configuration.nix
      ./laptop/configuration.nix

      inputs.hyprland.nixosModules.default

      inputs.nixos-hardware.nixosModules.framework-12th-gen-intel

      home-manager.nixosModules.home-manager
      {
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
