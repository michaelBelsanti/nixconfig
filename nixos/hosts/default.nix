{
  inputs,
  withSystem,
  homeImports,
  user,
  flakePath,
  ...
}: {
  flake.nixosConfigurations = withSystem "x86_64-linux" ({
    system,
    pkgs,
    ...
  }: let
    sharedModules = [
      ../.
      ../packages.nix
      inputs.hm.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = {inherit inputs user flakePath;};
        home-manager.users.${user}.imports = homeImports;
      }
    ];
  in {
    nix-desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {
        inherit inputs user flakePath;
      };
      modules =
        [
          ./desktop
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
          inputs.nix-gaming.nixosModules.pipewireLowLatency
        ]
        ++ sharedModules;
    };

    nix-laptop = inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {
        inherit inputs user flakePath;
      };
      modules =
        [
          ./laptop
          inputs.nix-gaming.nixosModules.pipewireLowLatency
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
        ]
        ++ sharedModules;
    };
  });
}
