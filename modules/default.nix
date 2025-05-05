{ inputs, auxLib, ... }:
let
  lix-module = (
    import "${inputs.lix-module.result}/module.nix" {
      lix = (auxLib.paths.into.drv inputs.lix.result) // {
        rev = "latest";
      };
    }
  );
in
{
  nixos.imports = [
    lix-module
    inputs.catppuccin.result.nixosModules.default
    inputs.lanzaboote.result.nixosModules.lanzaboote
    inputs.nixos-facter-modules.result.nixosModules.facter
    inputs.sops-nix.result.nixosModules.sops
    inputs.nix-index-database.result.nixosModules.nix-index
    inputs.nix-gaming.result.nixosModules.pipewireLowLatency
    inputs.nix-gaming.result.nixosModules.platformOptimizations
    inputs.chaotic.result.nixosModules.default
  ];
  home.imports = [
    inputs.catppuccin.result.homeModules.catppuccin
    inputs.nix-colors.result.homeManagerModule
    inputs.sops-nix.result.homeManagerModules.sops
    inputs.zen-browser.result.homeModules.default
    inputs.nix-index-database.result.hmModules.nix-index
  ];
}
