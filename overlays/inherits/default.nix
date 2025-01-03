# Packages to inherit from an input
{
  nixpkgs-master,
  helix,
  nix-gaming,
  plasma-manager,
  nix-alien,
  hypr-contrib,
  zen-browser,
  ...
}:
_self: super: {
  inherit (helix.packages.${super.system}) helix;
  inherit (plasma-manager.packages.${super.system}) rc2nix;
  inherit (nix-alien.packages.${super.system}) nix-alien;
  inherit (hypr-contrib.packages.${super.system}) grimblast;
  inherit (zen-browser.packages.${super.system}) zen-browser;
  gaming = nix-gaming.packages.${super.system};

  inherit (nixpkgs-master.legacyPackages.${super.system}) rocmPackages;
}
