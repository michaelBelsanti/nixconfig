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
      specialArgs = {inherit inputs user flakePath;};
      modules =
        [
          ./desktop
          inputs.nix-gaming.nixosModules.pipewireLowLatency
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          inputs.chaotic.nixosModules.default
          inputs.ssbm.nixosModule
        ]
        ++ sharedModules;
    };

    nix-laptop = inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit inputs user flakePath;};
      modules =
        [
          ./laptop
          inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        ]
        ++ sharedModules;
    };
    vm = inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit inputs user flakePath;};
      modules = [./vm] ++ sharedModules;
    };
  });
}
