{
  inputs,
  withSystem,
  user,
  flakePath,
  ...
}: let
  homeImports = [
    ../.
    ../packages.nix
    inputs.spicetify.homeManagerModule
    inputs.hyprland.homeManagerModules.default
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  inherit (inputs.hm.lib) homeManagerConfiguration;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake.homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
    "${user}@server" = homeManagerConfiguration {
      inherit pkgs;
      modules = homeImports;
      extraSpecialArgs = {
        inherit inputs user flakePath;
      };
    };
  });
}

